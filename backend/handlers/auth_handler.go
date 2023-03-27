package handlers

import (
    "fmt"
	"context"
	"time"
    "net/http"
    "database/sql"
    "encoding/json"
    "github.com/Skullriver/Sorbonne_PS3R.git/services"
    "github.com/Skullriver/Sorbonne_PS3R.git/repository"
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
}

type AuthHandler struct {
	auth *services.AuthService
}

func NewAuthHandler(db *sql.DB, tokenSecret string) *AuthHandler {
    auth := &services.AuthService{
        UserRepository: repository.NewPostgresUserRepository(db),
        TokenSecret:     tokenSecret,
        TokenLifetime:   time.Duration(3600) * time.Second,
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
    fmt.Println(token)

	// Create a LoginResponse with the JWT token
    resp := LoginResponse{Token: "test"}
    json.NewEncoder(w).Encode(resp)
}

func (h *AuthHandler) RegisterHandler(w http.ResponseWriter, r *http.Request) {
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
    err = h.auth.RegisterUser(ctx, req.Email, req.Password, req.Username)
    if err != nil {
        http.Error(w, err.Error(), http.StatusBadRequest)
        return
    }

    // Create a RegisterResponse with a success message
    resp := RegisterResponse{Message: "User registration successful"}
    json.NewEncoder(w).Encode(resp)
}