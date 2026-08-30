package config

import (
	"log"
	"os"
	"path/filepath"
	"runtime"

	"github.com/joho/godotenv"
)

type SConfig struct {
	DBConnection string
	DBHost       string
	DBPort       string
	DBDatabase   string
	DBUsername   string
	DBPassword   string
	DBEncrypt    string
	DBTrustCert  string

	DBProdHost     string
	DBProdPort     string
	DBProdDatabase string
	DBProdUsername string
	DBProdPassword string

	JWTSecret          string
	JWTExpiration      string
	RefreshTokenSecret string
	RefreshTokenExpiry string

	RedisURL string

	EnableGiroFeature     bool
	EnableDepositoFeature bool
}

func LoadConfig() *SConfig {
	// Resolve .env relative to this source file via runtime.Caller
	// config.go is at internal/infrastructure/config/config.go
	_, filename, _, _ := runtime.Caller(0)
	configDir := filepath.Dir(filename) // internal/infrastructure/config
	envPath := filepath.Join(configDir, "..", "..", "..", ".env")

	if info, err := os.Stat(envPath); err == nil && !info.IsDir() {
		// _ = godotenv.Load(envPath)
		// Use Overload instead of Load so that values in .env will overwrite
		// any existing environment variables in the current terminal session.
		_ = godotenv.Overload(envPath)
	} else {
		log.Println("Warning: .env file not found at expected path, using system environment variables")
	}

	return &SConfig{
		DBConnection: getEnv("DB_CONNECTION", "sqlsrv"),
		DBHost:       getEnv("DB_REPORT_HOST", "127.0.0.1"),
		DBPort:       getEnv("DB_REPORT_PORT", "1433"),
		DBDatabase:   getEnv("DB_REPORT_DATABASE", "DbDapenka"),
		DBUsername:   getEnv("DB_REPORT_USERNAME", "sa"),
		DBPassword:   getEnv("DB_REPORT_PASSWORD", ""),
		DBEncrypt:    getEnv("DB_ENCRYPT", "disable"),
		DBTrustCert:  getEnv("DB_TRUST_SERVER_CERTIFICATE", "true"),

		DBProdHost:     getEnv("DB_HOST", "36.93.24.50"),
		DBProdPort:     getEnv("DB_PORT", "1433"),
		DBProdDatabase: getEnv("DB_DATABASE", "dbbcagroup"),
		DBProdUsername: getEnv("DB_USERNAME", "sa"),
		DBProdPassword: getEnv("DB_PASSWORD", ""),

		JWTSecret:          getEnv("JWT_SECRET", "secret"),
		JWTExpiration:      getEnv("JWT_EXPIRATION", "15m"),
		RefreshTokenSecret: getEnv("REFRESH_TOKEN_SECRET", "refresh-secret"),
		RefreshTokenExpiry: getEnv("REFRESH_TOKEN_EXPIRY", "168h"),

		RedisURL: getEnv("REDIS_URL", "redis://localhost:6379"),

		EnableGiroFeature:     getEnv("ENABLE_GIRO_FEATURE", "false") == "true",
		EnableDepositoFeature: getEnv("ENABLE_DEPOSITO_FEATURE", "false") == "true",
	}
}

func getEnv(key, fallback string) string {
	if value, ok := os.LookupEnv(key); ok {
		return value
	}
	return fallback
}
