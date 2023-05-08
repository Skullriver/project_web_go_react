package handlers

import (
	"context"
	"database/sql"
	"encoding/json"
	"fmt"
	"github.com/Skullriver/Sorbonne_PS3R.git/repository"
	"github.com/Skullriver/Sorbonne_PS3R.git/services"
	"github.com/Skullriver/Sorbonne_PS3R.git/utility"
	"net/http"
	"os"
	"strconv"
	"strings"
	"time"
)

type BetHandler struct {
	api  *services.BetService
	auth *services.AuthService
}

func NewBetHandler(db *sql.DB, secretToken string) *BetHandler {
	authService := &services.AuthService{
		UserRepository: repository.NewPostgresUserRepository(db),
		TokenSecret:    secretToken,
		TokenLifetime:  time.Duration(3600) * time.Second,
	}
	api := &services.BetService{
		UserRepository:       repository.NewPostgresUserRepository(db),
		LineRepository:       repository.NewPostgresLineRepository(db),
		DisruptionRepository: repository.NewPostgresDisruptionRepository(db),
		LogRepository:        repository.NewPostgresLogRepository(db),
		BetRepository:        repository.NewPostgresBetRepository(db),
	}
	return &BetHandler{api: api, auth: authService}
}

func (h *BetHandler) InfoBetHandler(w http.ResponseWriter, r *http.Request) {

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

	// Call the
	response := h.api.GetInfoForCreation(ctx)
	// Print the response body
	err = json.NewEncoder(w).Encode(response)
	if err != nil {
		return
	}
}

func (h *BetHandler) CreateBetHandler(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Access-Control-Allow-Methods", "POST")
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
	userID, err := h.auth.VerifyToken(ctx, tokenString)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	var req utility.CreateBetRequest
	err = json.NewDecoder(r.Body).Decode(&req)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	// Call the
	BetID, err := h.api.CreateBet(ctx, req, userID)

	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	// Print the response body
	resp := utility.BetCreationResponse{Message: fmt.Sprintf("Bet #%d was created", BetID), BetID: BetID}
	json.NewEncoder(w).Encode(resp)

}
