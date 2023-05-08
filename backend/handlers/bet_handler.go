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

type BetHandler struct {
	api *services.BetService
}

func NewBetHandler(db *sql.DB) *BetHandler {
	api := &services.BetService{
		UserRepository:       repository.NewPostgresUserRepository(db),
		LineRepository:       repository.NewPostgresLineRepository(db),
		DisruptionRepository: repository.NewPostgresDisruptionRepository(db),
		LogRepository:        repository.NewPostgresLogRepository(db),
	}
	return &BetHandler{api: api}
}

func (h *BetHandler) BetHandler(w http.ResponseWriter, r *http.Request) {

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
