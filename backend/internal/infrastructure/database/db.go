package database

import (
	"fmt"
	"log"
	"regexp"
	"strings"

	"github.com/masza1/dapen-backend/internal/features/activity"
	"github.com/masza1/dapen-backend/internal/infrastructure/config"
	"gorm.io/driver/sqlserver"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

var DB *gorm.DB
var ProdDB *gorm.DB

// fetchNextPattern matches the LIMIT clause fragment GORM's sqlserver dialect
// emits for paginated / probe queries:
//
//   OFFSET 0 ROW FETCH NEXT 1 ROWS ONLY
//   OFFSET 10 ROWS FETCH NEXT 25 ROWS ONLY
//
// Neither form is understood by SQL Server 2008 R2 (OFFSET ... FETCH NEXT was
// introduced in SQL Server 2012), and on top of that the driver writes
// "ROWS ONLY" plural when the SQL standard (and SQL Server) require singular
// "ROW ONLY". We rewrite this fragment to a SQL 2008-compatible pattern:
//
//   TOP <N>
//
// which every SQL Server version (2005/2008/2012+/2019) accepts.
var fetchNextPattern = regexp.MustCompile(`(?is)\boffset\s+\d+\s+rows?\s+fetch\s+next\s+(\d+)\s+rows?\s+only\b`)

func rewriteSQL2008(sql string) string {
	if !strings.Contains(strings.ToLower(sql), "fetch next") {
		return sql
	}
	matches := fetchNextPattern.FindStringSubmatchIndex(sql)
	if matches == nil {
		return sql
	}
	// Find the SELECT keyword so we can decide whether to inject TOP <n>
	// immediately after it (SQL Server TOP-only-one-per-SELECT rule).
	lower := strings.ToLower(sql)
	selIdx := strings.Index(lower, "select")
	if selIdx < 0 {
		return sql
	}
	insertAt := selIdx + len("select")

	// If the statement already starts with `SELECT TOP ...` (e.g. an outer
	// chained builder pre-supplied TOP, or a subquery written as
	// `SELECT TOP (n) ...`), do NOT inject another TOP — SQL Server would
	// raise "Incorrect syntax near 'TOP'." Just strip the OFFSET...FETCH
	// fragment instead.
	remaining := sql[insertAt:]
	if len(remaining) > 0 {
		peekLen := len(remaining)
		if peekLen > 24 {
			peekLen = 24
		}
		if strings.Contains(strings.ToLower(remaining[:peekLen]), "top") {
			// Strip the OFFSET...FETCH fragment. `matches[0]` points at the
			// space right before "OFFSET", so sql[:matches[0]] already
			// includes that trailing space — TrimRight keeps the rewritten
			// SQL tidy.
			return strings.TrimRight(sql[:matches[0]]+sql[matches[1]:], " ")
		}
	}

	n := fetchNextPattern.FindStringSubmatch(sql)[1]
	prefix := sql[:insertAt]
	// Strip a single trailing space from `head` if present: the OFFSET
	// clause is always preceded by exactly one space in the GORM-emitted
	// form (" ORDER BY x OFFSET ..."), and trimming keeps the rewritten
	// SQL tidy when `tail` is empty (e.g. probe queries).
	head := strings.TrimSuffix(sql[insertAt:matches[0]], " ")
	tail := sql[matches[1]:]
	return prefix + " TOP " + n + head + tail
}

func InitProdDB(cfg *config.SConfig) *gorm.DB {
	dsn := fmt.Sprintf("sqlserver://%s:%s@%s:%s?database=%s&encrypt=%s&trustServerCertificate=%s",
		cfg.DBProdUsername,
		cfg.DBProdPassword,
		cfg.DBProdHost,
		cfg.DBProdPort,
		cfg.DBProdDatabase,
		cfg.DBEncrypt,
		cfg.DBTrustCert,
	)

	var err error
	ProdDB, err = gorm.Open(sqlserver.Open(dsn), &gorm.Config{
		Logger: logger.Default.LogMode(logger.Info),
	})

	if err != nil {
		log.Fatalf("Failed to connect to production database: %v", err)
	}

	installSQL2008Shim(ProdDB)
	log.Printf("Production database connection established %s:%s/%s", cfg.DBProdHost, cfg.DBProdPort, cfg.DBProdDatabase)
	return ProdDB
}

func InitDB(cfg *config.SConfig) *gorm.DB {
	// Build connection string
	// sqlserver://username:password@localhost:1433?database=dbname
	dsn := fmt.Sprintf("sqlserver://%s:%s@%s:%s?database=%s&encrypt=%s&trustServerCertificate=%s",
		cfg.DBUsername,
		cfg.DBPassword,
		cfg.DBHost,
		cfg.DBPort,
		cfg.DBDatabase,
		cfg.DBEncrypt,
		cfg.DBTrustCert,
	)

	var err error
	DB, err = gorm.Open(sqlserver.Open(dsn), &gorm.Config{
		Logger: logger.Default.LogMode(logger.Info),
	})

	if err != nil {
		log.Fatalf("Failed to connect to database: %v", err)
	}

	// Register Activity Log Plugin to track database changes
	// Loads activity_log_config from DB and registers GORM callbacks
	activity.RegisterActivityLogPlugin(DB)

	installSQL2008Shim(DB)
	log.Printf("Database connection established %s:%s/%s", cfg.DBHost, cfg.DBPort, cfg.DBDatabase)
	log.Println("Activity logging plugin registered")
	return DB
}

func installSQL2008Shim(dbConn *gorm.DB) {
	// SQL Server 2008 R2 compatibility shim.
	//
	// GORM's sqlserver dialect always emits `OFFSET ... FETCH NEXT ... ROWS ONLY`
	// for paginated queries. That syntax was introduced in SQL Server 2012 and is
	// not understood by the project's 2008 R2 backend, which raises
	// "Invalid usage of the option NEXT in the FETCH statement." (Worse, the
	// clause builder also writes "ROW(S) ... ROWS ONLY" where SQL Server requires
	// singular "ROW ... ROW ONLY", so even 2012+ can refuse it.)
	//
	// Strategy: replace the `gorm:query` callback. We need to (1) preserve
	// all of GORM's existing BuildQuerySQL logic — Schema-aware column lists,
	// auto-WHERE on primary key, joins, omits, preloads, etc. — and (2)
	// rewrite the assembled SQL to drop OFFSET...FETCH and inject TOP n.
	//
	// We do (1) by manually invoking the original `gorm:query` handler under
	// `DryRun=true`. BuildQuerySQL runs (so all clause setup happens),
	// but the actual `ConnPool.QueryContext` is skipped. We capture the
	// assembled SQL, rewrite it for SQL Server 2008, and then send it
	// ourselves with `ConnPool.QueryContext` / Scan.
	originalQuery := dbConn.Callback().Query().Get("gorm:query")
	if originalQuery == nil {
		log.Fatalf("SQL Server 2008 compatibility shim: gorm:query handler not found")
	}
	if err := dbConn.Callback().Query().Replace("gorm:query", func(tx *gorm.DB) {
		if tx.Error != nil {
			return
		}
		if tx.Statement == nil {
			// Nothing to do; defer to original so its nil-safety path runs.
			originalQuery(tx)
			return
		}

		// Always capture a copy of tx.Statement.SQL / Vars so we can run the
		// original handler (DryRun) on a fresh statement without tearing down
		// the user's state.
		originalSQL := tx.Statement.SQL.String()
		originalVars := append([]any(nil), tx.Statement.Vars...)

		// Run the original handler in DryRun mode to assemble the SQL.
		dryRun := tx.DryRun
		tx.DryRun = true
		originalQuery(tx)
		tx.DryRun = dryRun

		// If the original handler populated SQL (the normal case), rewrite it.
		// If it left SQL empty (e.g. pure `.Exec`), fall through and let the
		// original's work stand.
		rewritten := tx.Statement.SQL.String()
		if rewritten == "" {
			tx.Statement.SQL.Reset()
			tx.Statement.SQL.WriteString(originalSQL)
			tx.Statement.Vars = originalVars
			if !dryRun {
				// Re-run without DryRun so the actual execution happens.
				tx.DryRun = false
				tx.Statement.SQL.Reset()
				tx.Statement.SQL.WriteString(originalSQL)
				tx.Statement.Vars = originalVars
				originalQuery(tx)
			}
			return
		}

		// Apply the SQL Server 2008 rewrite (OFFSET...FETCH -> TOP n).
		rewritten = rewriteSQL2008(rewritten)
		tx.Statement.SQL.Reset()
		tx.Statement.SQL.WriteString(rewritten)

		if dryRun {
			// Caller just wants the SQL; we're done.
			return
		}

		// Real execution: send the rewritten SQL and scan results.
		rows, err := tx.Statement.ConnPool.QueryContext(tx.Statement.Context, tx.Statement.SQL.String(), tx.Statement.Vars...)
		if err != nil {
			tx.AddError(err)
			return
		}
		defer func() { _ = rows.Close() }()
		gorm.Scan(rows, tx, 0)
		if tx.Statement.Result != nil {
			tx.Statement.Result.RowsAffected = tx.RowsAffected
		}
	}); err != nil {
		log.Fatalf("Failed to install SQL Server 2008 compatibility shim (query): %v", err)
	}

	// Same shim for the Row processor, used by `.Rows()` / `.Row()` chains such
	// as the sqlserver driver's column-probe query
	//   `db.Table(...).Limit(1).Rows()`
	// which is what AutoMigrate issues while checking existing schema.
	originalRow := dbConn.Callback().Row().Get("gorm:row")
	if originalRow == nil {
		log.Fatalf("SQL Server 2008 compatibility shim: gorm:row handler not found")
	}
	if err := dbConn.Callback().Row().Replace("gorm:row", func(tx *gorm.DB) {
		// Mirror the Query shim: build via the original handler in DryRun
		// mode so all of BuildQuerySQL's Schema-aware logic still runs,
		// then rewrite the assembled SQL to be SQL Server 2008-friendly,
		// then do the real QueryRow/Query call ourselves.
		if tx.Error != nil {
			return
		}
		if tx.Statement == nil {
			originalRow(tx)
			return
		}

		dryRun := tx.DryRun
		tx.DryRun = true
		originalRow(tx)
		tx.DryRun = dryRun

		if tx.Statement.SQL.Len() == 0 {
			// No SQL was built (rare); defer to the original handler with
			// DryRun restored so the original can do its thing.
			tx.DryRun = dryRun
			originalRow(tx)
			return
		}

		rewritten := rewriteSQL2008(tx.Statement.SQL.String())
		tx.Statement.SQL.Reset()
		tx.Statement.SQL.WriteString(rewritten)

		if dryRun {
			return
		}

		// Execute. RowQuery normally picks QueryRow vs Query based on the
		// "rows" setting (Set("rows", true) from `.Rows()`). We replicate
		// that here so callers still get a *sql.Rows or *sql.Row in the
		// right place.
		isRows, _ := tx.Get("rows")
		if br, ok := isRows.(bool); ok && br {
			tx.Statement.Settings.Delete("rows")
			rs, err := tx.Statement.ConnPool.QueryContext(tx.Statement.Context, tx.Statement.SQL.String(), tx.Statement.Vars...)
			if err != nil {
				tx.AddError(err)
				return
			}
			tx.Statement.Dest = rs
		} else {
			tx.Statement.Dest = tx.Statement.ConnPool.QueryRowContext(tx.Statement.Context, tx.Statement.SQL.String(), tx.Statement.Vars...)
		}
		tx.RowsAffected = -1
	}); err != nil {
		log.Fatalf("Failed to install SQL Server 2008 compatibility shim (row): %v", err)
	}

	log.Println("SQL Server 2008 compatibility shim enabled (OFFSET...FETCH -> TOP)")
}
