package main

import (
    "fmt"
	"os"
	"github.com/joho/godotenv"
	"database/sql"
    "net/http"
	"log"
	"github.com/gorilla/mux"
	"github.com/Skullriver/Sorbonne_PS3R.git/handlers"
	_ "github.com/lib/pq"
)

func init() {
	loadTheEnv()
}

func loadTheEnv(){
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
        if r.Method == "OPTIONS" {
            w.WriteHeader(http.StatusNoContent)
            return
        }
        next.ServeHTTP(w, r)
    })
}

func setupRoutes() *mux.Router {
	
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

    r := mux.NewRouter()
	r.Use(corsMiddleware)

    authHandler := handlers.NewAuthHandler(db, "my-secret-token")
    r.HandleFunc("/register", authHandler.RegisterHandler).Methods("POST")
    r.HandleFunc("/login", authHandler.LoginHandler).Methods("POST", "OPTIONS")

    // ... other routes ...

    return r
}

func main() {

    r := setupRoutes()
	// corsMiddleware := cors.New(cors.Options{
    //     AllowedOrigins: []string{"http://localhost:3000"},
    //     AllowedHeaders: []string{"Authorization", "Content-Type"},
    //     AllowedMethods: []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
    // })
    // handler := corsMiddleware.Handler(r)
	fmt.Println("starting the server on port 8080...")

    log.Fatal(http.ListenAndServe(":8080", r))
}