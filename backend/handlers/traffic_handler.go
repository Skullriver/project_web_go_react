package handlers

import (
	"context"
	"database/sql"
	"encoding/json"
	"github.com/Skullriver/Sorbonne_PS3R.git/repository"
	"github.com/Skullriver/Sorbonne_PS3R.git/services"
	"net/http"
	"os"
	"strconv"
	"strings"
	"time"
)

type TrafficHandler struct {
	api  *services.TrafficService
	auth *services.AuthService
}

func NewTrafficHandler(db *sql.DB, secretToken string) *TrafficHandler {
	authService := &services.AuthService{
		UserRepository: repository.NewPostgresUserRepository(db),
		TokenSecret:    secretToken,
		TokenLifetime:  time.Duration(3600) * time.Second,
	}
	api := &services.TrafficService{
		UserRepository:       repository.NewPostgresUserRepository(db),
		LineRepository:       repository.NewPostgresLineRepository(db),
		DisruptionRepository: repository.NewPostgresDisruptionRepository(db),
		LogRepository:        repository.NewPostgresLogRepository(db),
	}
	return &TrafficHandler{api: api, auth: authService}
}

func (h *TrafficHandler) TrafficHandler(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Access-Control-Allow-Methods", "GET")
	w.Header().Set("Access-Control-Allow-Headers", "Content-Type")

	// Check request method
	if r.Method == "OPTIONS" {
		w.WriteHeader(http.StatusOK)
		return
	}

	// Create a new context with a timeout of 5 seconds
	timeString := os.Getenv("CONTEXT_TIME")
	timeValue, err := strconv.Atoi(timeString)

	if err != nil {
		// Handle error
		panic(err)
	}

	contextTime := time.Duration(timeValue) * time.Second
	ctx, cancel := context.WithTimeout(context.Background(), contextTime)
	defer cancel()

	// Get token from Authorization header
	authHeader := r.Header.Get("Authorization")
	if authHeader == "" {
		// Return an error response if no Authorization header is found
		http.Error(w, "Unauthorized", http.StatusUnauthorized)
		return
	}

	// Parse token from Authorization header
	tokenString := strings.Replace(authHeader, "Bearer ", "", 1)
	_, err = h.auth.VerifyToken(ctx, tokenString)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	response := h.api.GetTraffic(ctx)
	// Print the response body
	err = json.NewEncoder(w).Encode(response)
	if err != nil {
		return
	}
}
