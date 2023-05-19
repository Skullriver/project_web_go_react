package routines

import (
	"context"
	"database/sql"
	"github.com/Skullriver/Sorbonne_PS3R.git/services"
	"os"
	"time"
)

func VerifyTraffic(db *sql.DB, ctx context.Context) {
	for {
		//fmt.Println("executing goroutine to update traffic reports...")

		apiService := services.NewApiService(db)
		apiService.UpdateTraffic(ctx, os.Getenv("API_REQUEST_METRO"))
		apiService.UpdateTraffic(ctx, os.Getenv("API_REQUEST_RER"))

		//fmt.Println("traffic updated.")

		time.Sleep(5 * time.Minute)
	}
}
