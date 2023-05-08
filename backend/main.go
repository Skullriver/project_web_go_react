package main

import (
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
	trafficHandler := handlers.NewTrafficHandler(db)
	betHandler := handlers.NewBetHandler(db)

	r.HandleFunc("/user/register", authHandler.RegisterHandler).Methods("POST", "OPTIONS")
	r.HandleFunc("/user/login", authHandler.LoginHandler).Methods("POST", "OPTIONS")
	r.HandleFunc("/api/traffic", trafficHandler.TrafficHandler).Methods("GET")
	r.HandleFunc("/api/betCreationInfo", betHandler.BetHandler).Methods("GET")

	return r
}

func main() {

	db, err := sql.Open("postgres", os.Getenv("DB_URI"))
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

	go routines.VerifyTraffic(db)

	fmt.Println("starting the server on port 8080...")

	log.Fatal(http.ListenAndServe(":8080", r))
}
