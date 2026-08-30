package app

import (
	"time"

	"github.com/gin-gonic/gin"
	"github.com/masza1/dapen-backend/internal/features/accounting/kasbank"
	"github.com/masza1/dapen-backend/internal/features/activity"
	"github.com/masza1/dapen-backend/internal/features/reports"
	"github.com/masza1/dapen-backend/internal/features/reports/execution"
	"github.com/masza1/dapen-backend/internal/app/routes"
	"github.com/masza1/dapen-backend/internal/features/browse"
	"github.com/masza1/dapen-backend/internal/features/settings"
	"github.com/masza1/dapen-backend/internal/features/dashboard"
	"github.com/masza1/dapen-backend/internal/features/filters"
	"github.com/masza1/dapen-backend/internal/legacy/handlers"
	"github.com/masza1/dapen-backend/internal/features/identity/auth"
	"github.com/masza1/dapen-backend/internal/features/identity/permission"
	"github.com/masza1/dapen-backend/internal/features/identity/user"
	"github.com/masza1/dapen-backend/internal/features/menu"
	"github.com/masza1/dapen-backend/internal/features/session"
	"github.com/masza1/dapen-backend/internal/legacy/repositories"
	"github.com/masza1/dapen-backend/internal/legacy/services"
	"github.com/masza1/dapen-backend/internal/infrastructure/config"
	"github.com/masza1/dapen-backend/internal/infrastructure/database"
	"github.com/masza1/dapen-backend/internal/infrastructure/middleware"
	"golang.org/x/time/rate"
	"gorm.io/gorm"
)

// NewApp initializes all dependencies, middlewares, and routes, returning a configured Gin engine.
//
// Domain-Based DI: each domain package owns its repository + service + handler constructors.
// Shared infrastructure (config, database connection, redis) is injected once and passed down.
func NewApp(dbConn *gorm.DB, prodDbConn *gorm.DB, cfg *config.SConfig) *gin.Engine {
	// 1. Initialize Identity domain (auth + user + permission).
	userRepo := user.NewUserRepository(dbConn)
	authService := auth.NewAuthService(userRepo, cfg)
	userService := user.NewUserService(userRepo)
	permissionRepo := permission.NewPermissionRepository(dbConn)
	permissionService := permission.NewPermissionService(permissionRepo)

	authHandler := auth.NewAuthHandler(authService)
	userHandler := user.NewUserHandler(userRepo, userService)
	permissionHandler := permission.NewPermissionHandler(permissionRepo, permissionService)

	// 2. Initialize Menu and Filter domains.
	menuRepo := menu.NewMenuRepository(dbConn)
	menuService := menu.NewMenuService(menuRepo)
	menuHandler := menu.NewMenuHandler(menuService)

	filterRepo := filters.NewFilterRepository(dbConn)
	filterService := filters.NewFilterService(filterRepo)
	filterHandler := filters.NewFilterHandler(filterService)

	// 3. Initialize Activity Log domain.
	activityLogRepo := activity.NewActivityLogRepository(dbConn)
	activityLogService := activity.NewActivityLogService(activityLogRepo)
	activityLogHandler := activity.NewActivityLogHandler(activityLogService, database.DB)

	// 3.5 Initialize Session domain (depends on Redis for session storage).
	sessionRepo := session.NewSessionRepository(database.RedisClient)
	sessionService := session.NewSessionService(sessionRepo, dbConn)
	sessionHandler := session.NewSessionHandler(sessionService, userRepo)

	// 4. Initialize Dashboard domain (handler-only, no separate service).
	dashboardHandler := dashboard.NewDashboardHandler(dbConn)

	// 5. Initialize the legacy Berkas/Settings handlers (periode + setting).
	//    These still live in the legacy handlers/ package and depend on
	//    legacy models + services. They are scheduled for migration to
	//    accounting/periode and a new settings/ domain in a follow-up sprint.
	periodeRepo := repositories.NewPeriodeRepository(dbConn)
	periodeService := services.NewPeriodeService(periodeRepo)
	periodeHandler := handlers.NewPeriodeHandler(periodeService)
	settingHandler := handlers.NewSettingHandler(dbConn)
	settingsHandler := settings.NewSettingHandler(dbConn, cfg)

	// 5.5 Initialize Accounting > Kas Bank domain (TASK-015). The
	// permission middleware is shared so other accounting sub-domains
	// (jurnal, periode migration, ...) can reuse it. The settings.Service
	// is passed through so kasbank can delegate voucher-number generation
	// (FORMAT1..4 / PEMISAH / counter) to it instead of re-implementing
	// the algorithm here.
	kasBankPermMW := middleware.NewPermissionMiddleware(dbConn)
	settingsSvc := settings.NewService(dbConn)
	kasBankRepo := kasbank.NewSKasBankRepository(dbConn, settingsSvc)
	kasBankService := kasbank.NewSKasBankService(kasBankRepo, dbConn, cfg, settingsSvc)
	kasBankHandler := kasbank.NewSKasBankHandler(kasBankService)

	// 5.6 Initialize Browse domain. Browse is a generic lookup facility
	// (Perkiraan, Customer/Supplier, Kas/Bank, etc.) driven by the
	// dbbrowseconfigs table with a hardcoded fallback map. No menu-level
	// permission is enforced at this layer — callers (e.g. kasbank's
	// /lookup-perkiraan) gate access themselves.
	browseResolver := browse.NewConfigResolver(dbConn)
	browseHandler := browse.NewHandler(browseResolver)

	// 5.7 Initialize Reports domain (admin + execution).
	reportsRepo := reports.NewReportsRepository(dbConn)
	reportsService := reports.NewReportsService(reportsRepo)
	reportsHandler := reports.NewReportsHandler(reportsService)
	reportExecRepo := execution.NewReportExecutionRepository(dbConn, prodDbConn)
	reportExecService := execution.NewReportExecutionService(reportExecRepo)
	reportExecHandler := execution.NewReportExecutionHandler(reportExecService, reportsService)
	reportExportHandler := reports.NewReportExportHandler(reportExecRepo)

	// 6. Initialize the Gin engine and global middlewares.
	engine := gin.Default()
	engine.SetTrustedProxies(nil)
	engine.Use(gin.Recovery())
	engine.Use(gin.Logger())

	// Rate Limit: 10 req/sec per IP with burst of 20. The limiter factory
	// transparently switches between an in-memory token bucket and a Redis-backed
	// limiter based on whether the Redis client is available.
	limiter := middleware.GetRateLimiter(database.RedisClient, rate.Limit(10), 20)
	engine.Use(limiter.RateLimitMiddleware())

	// Timeout: 5 minutes (300 seconds) for heavy enterprise reports.
	engine.Use(middleware.TimeoutMiddleware(300 * time.Second))

	// 7. Wire all routes.
	routes.SetupRoutes(routes.SRouterConfig{
		Engine:              engine,
		SAuthHandler:        authHandler,
		SDashboardHandler:   dashboardHandler,
		SFilterHandler:      filterHandler,
		SMenuHandler:        menuHandler,
		SActivityLogHandler: activityLogHandler,
		SPeriodeHandler:     periodeHandler,
		SSettingHandler:     settingHandler,
		SSettingsHandler:    settingsHandler,
		SUserHandler:        userHandler,
		SPermissionHandler:  permissionHandler,
		SSessionHandler:     sessionHandler,
		SKasBankHandler:     kasBankHandler,
		SKasBankPermMW:      kasBankPermMW,
		SBrowseHandler:      browseHandler,
		SReportsHandler:     reportsHandler,
		SReportExecHandler:  reportExecHandler,
		SReportExportHandler: reportExportHandler,
		SConfig:             cfg,
	})

	return engine
}
