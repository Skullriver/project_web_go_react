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

type LoginRequest struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type RegisterRequest struct {
	Email    string `json:"email"`
	Password string `json:"password"`
	Username string `json:"username"`
}

type LoginResponse struct {
	Token string `json:"token"`
}

type RegisterResponse struct {
	Message string `json:"message"`
	Token   string `json:"token"`
}

type AuthHandler struct {
	auth *services.AuthService
}

func NewAuthHandler(db *sql.DB, tokenSecret string) *AuthHandler {
	auth := &services.AuthService{
		UserRepository: repository.NewPostgresUserRepository(db),
		TokenSecret:    tokenSecret,
		TokenLifetime:  time.Duration(3600) * time.Second,
	}
	return &AuthHandler{auth: auth}
}

func (h *AuthHandler) LoginHandler(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Access-Control-Allow-Methods", "POST")
	w.Header().Set("Access-Control-Allow-Headers", "Content-Type")

	// Check request method
	if r.Method == "OPTIONS" {
		w.WriteHeader(http.StatusOK)
		return
	}

	var req LoginRequest
	err := json.NewDecoder(r.Body).Decode(&req)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	// Create a new context with a timeout of 5 seconds
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	// Call the LoginUser function from the AuthService
	token, err := h.auth.LoginUser(ctx, req.Email, req.Password)
	if err != nil {
		http.Error(w, err.Error(), http.StatusUnauthorized)
		return
	}

	// Create a LoginResponse with the JWT token
	resp := LoginResponse{Token: token}
	json.NewEncoder(w).Encode(resp)
}

func (h *AuthHandler) RegisterHandler(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Access-Control-Allow-Methods", "POST")
	w.Header().Set("Access-Control-Allow-Headers", "Content-Type")

	// Check request method
	if r.Method == "OPTIONS" {
		w.WriteHeader(http.StatusOK)
		return
	}

	var req RegisterRequest
	err := json.NewDecoder(r.Body).Decode(&req)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	// Create a new context with a timeout of 5 seconds
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	// Call the RegisterUser function from the AuthService
	token, err := h.auth.RegisterUser(ctx, req.Email, req.Password, req.Username)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	// Create a RegisterResponse with a success message
	resp := RegisterResponse{Message: "User registration successful", Token: token}
	json.NewEncoder(w).Encode(resp)
}

func (h *AuthHandler) GetUserHandler(w http.ResponseWriter, r *http.Request) {
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
	userID, err := h.auth.VerifyToken(ctx, tokenString)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	// Call the
	user, err := h.auth.GetUserByID(ctx, userID)

	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	resp := struct {
		UserID   int64   `json:"user_id"`
		Username string  `json:"username"`
		Balance  float64 `json:"balance"`
	}{
		UserID:   user.ID,
		Username: user.Username,
		Balance:  user.AccountBalance,
	}
	// Print the response body
	json.NewEncoder(w).Encode(resp)
}
