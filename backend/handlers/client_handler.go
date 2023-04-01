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
	"time"
)

type ClientHandler struct {
	api *services.ClientService
}

func NewClientHandler(db *sql.DB) *ClientHandler {
	api := &services.ClientService{
		UserRepository:       repository.NewPostgresUserRepository(db),
		LineRepository:       repository.NewPostgresLineRepository(db),
		DisruptionRepository: repository.NewPostgresDisruptionRepository(db),
		LogRepository:        repository.NewPostgresLogRepository(db),
	}
	return &ClientHandler{api: api}
}

func (h *ClientHandler) TrafficHandler(w http.ResponseWriter, r *http.Request) {

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

	// Call the LoginUser function from the AuthService
	response := h.api.GetTraffic(ctx)
	// Print the response body
	err = json.NewEncoder(w).Encode(response)
	if err != nil {
		return
	}
}
