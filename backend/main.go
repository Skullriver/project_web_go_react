package main

import (
	"context"
	"database/sql"
	"fmt"
	"github.com/Skullriver/Sorbonne_PS3R.git/handlers"
	"github.com/Skullriver/Sorbonne_PS3R.git/routines"
	"github.com/gorilla/mux"
	"github.com/joho/godotenv"
	_ "github.com/lib/pq"
	"log"
	"net/http"
	"os"
	"strconv"
	"time"
)

func init() {
	loadTheEnv()
}

func loadTheEnv() {
	err := godotenv.Load(".env")
	if err != nil {
		log.Fatal("Error loading .env file")
	}
}

func corsMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Access-Control-Allow-Origin", "*")
		w.Header().Set("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE")
		w.Header().Set("Access-Control-Allow-Headers", "Content-Type, Authorization")
		w.Header().Set("Content-Security-Policy", "default-src 'self'")
		if r.Method == "OPTIONS" {
			w.WriteHeader(http.StatusNoContent)
			return
		}
		next.ServeHTTP(w, r)
	})
}

func setupRoutes(db *sql.DB) *mux.Router {

	r := mux.NewRouter()
	r.Use(corsMiddleware)

	authHandler := handlers.NewAuthHandler(db, "my-secret-token")
	trafficHandler := handlers.NewTrafficHandler(db, "my-secret-token")
	betHandler := handlers.NewBetHandler(db, "my-secret-token")

	r.HandleFunc("/user/register", authHandler.RegisterHandler).Methods("POST", "OPTIONS")
	r.HandleFunc("/user/login", authHandler.LoginHandler).Methods("POST", "OPTIONS")
	r.HandleFunc("/traffic/get", trafficHandler.TrafficHandler).Methods("GET", "OPTIONS")
	r.HandleFunc("/bet/creationInfo/get", betHandler.InfoBetHandler).Methods("GET", "OPTIONS")
	r.HandleFunc("/bet/create", betHandler.CreateBetHandler).Methods("POST", "OPTIONS")
	r.HandleFunc("/bet/active/get", betHandler.GetActiveBetsHandler).Methods("GET", "OPTIONS")
	r.HandleFunc("/user/get", betHandler.GetUserHandler).Methods("GET", "OPTIONS")
	r.HandleFunc("/bet/{betId}", betHandler.GetBetHandler).Methods("GET", "OPTIONS")
	r.HandleFunc("/bet/take", betHandler.TakeBetHandler).Methods("POST", "OPTIONS")

	return r
}

func main() {

	postgresHost := os.Getenv("POSTGRES_HOST")
	postgresUser := os.Getenv("DB_USER")
	postgresPass := os.Getenv("DB_PASS")
	postgresName := os.Getenv("DB_NAME")

	db, err := sql.Open("postgres", fmt.Sprintf("host=%s port=5432 user=%s password=%s dbname=%s sslmode=disable", postgresHost, postgresUser, postgresPass, postgresName))
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	err = db.Ping()
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println("Connected to the database!")

	r := setupRoutes(db)

	timeString := os.Getenv("CONTEXT_TIME")
	timeValue, err := strconv.Atoi(timeString)

	if err != nil {
		// Handle error
		panic(err)
	}

	contextTime := time.Duration(timeValue) * time.Second

	ctx, cancel := context.WithTimeout(context.Background(), contextTime)
	defer cancel()

	go routines.VerifyTraffic(db, ctx)
	go routines.VerifyBet(db, ctx)

	fmt.Println("starting the server on port 8080...")

	log.Fatal(http.ListenAndServe(":8080", r))
}
