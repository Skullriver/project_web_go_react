package handlers

import (
	"database/sql"
	"github.com/Skullriver/Sorbonne_PS3R.git/repository"
	"github.com/Skullriver/Sorbonne_PS3R.git/services"
)

type ApiHandler struct {
	api *services.ApiService
}

func NewApiHandler(db *sql.DB) *ApiHandler {
	api := &services.ApiService{
		LineRepository:       repository.NewPostgresLineRepository(db),
		DisruptionRepository: repository.NewPostgresDisruptionRepository(db),
	}
	return &ApiHandler{api: api}
}

//func (h *ApiHandler) RequestHandler(w http.ResponseWriter, r *http.Request) {
//
//	timeString := os.Getenv("CONTEXT_TIME")
//	timeValue, err := strconv.Atoi(timeString)
//
//	if err != nil {
//		// Handle error
//		panic(err)
//	}
//
//	contextTime := time.Duration(timeValue) * time.Second
//
//	ctx, cancel := context.WithTimeout(context.Background(), contextTime)
//	defer cancel()
//
//	response := h.api.UpdateTraffic(ctx)
//
//	// Print the response body
//	json.NewEncoder(w).Encode(response)
//}
