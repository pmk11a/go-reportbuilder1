package main

import (
	"flag"
	"log"

	"github.com/masza1/dapen-backend/internal/infrastructure/config"
	"github.com/masza1/dapen-backend/internal/infrastructure/database"
	"github.com/masza1/dapen-backend/internal/infrastructure/database/seeders"
	"github.com/masza1/dapen-backend/internal/infrastructure/logger"
	"github.com/masza1/dapen-backend/internal/app"

	_ "github.com/masza1/dapen-backend/docs"
	"gorm.io/gorm"
	gormlogger "gorm.io/gorm/logger"
)

// @title DAPEN System API
// @version 1.0
// @description Backend API for DAPEN management of employee retirement funds
// @host localhost:8081
// @BasePath /api

func main() {
	log.Println("DEBUG: Parsing flags")
	// 0. Parse CLI Flags
	runMigrate := flag.Bool("migrate", false, "Run database migrations")
	runSeed := flag.Bool("seed", false, "Run database seeds")
	flag.Parse()

	log.Println("DEBUG: Initializing logger")
	// 0.5 Initialize Logger
	if err := logger.InitLogger(); err != nil {
		log.Fatalf("Failed to initialize logger: %v", err)
	}
	defer logger.Close()

	log.Println("DEBUG: Loading config")
	// 1. Load SConfig
	cfg := config.LoadConfig()

	log.Printf("--- Configuration Loaded ---")
	log.Printf("Host : %s", cfg.DBHost)
	log.Printf("----------------------------")

	log.Println("DEBUG: Initializing DB")
	// 2. Initialize Database Connection
	dbConn := database.InitDB(cfg)
	prodDbConn := database.InitProdDB(cfg)

	log.Println("DEBUG: Initializing Redis")
	// 3. Initialize Redis Connection (for BFF session storage)
	database.InitRedis(cfg)

	log.Println("DEBUG: Conditional DB Operations")
	// 4. Conditional DB Operations
	if *runMigrate {
		// Use an error logger for migrations to avoid noisy output, but still show errors
		silentDB := dbConn.Session(&gorm.Session{Logger: dbConn.Logger.LogMode(gormlogger.Error)})
		database.RunMigrations(silentDB)
	}

	if *runSeed {
		// Use an error logger for seeds to avoid noisy output, but still show errors
		silentDB := dbConn.Session(&gorm.Session{Logger: dbConn.Logger.LogMode(gormlogger.Error)})
		seeders.SeedDatabase(silentDB)
	}

	log.Println("DEBUG: Initializing Server (NewApp)")
	// 5. Initialize Server (DI & Routing)
	engine := app.NewApp(dbConn, prodDbConn, cfg)

	// 10. Start server
	log.Printf("Starting server on port 8081...")
	if err := engine.Run(":8081"); err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}
}