package routines

import (
	"context"
	"database/sql"
	"fmt"
	"github.com/Skullriver/Sorbonne_PS3R.git/services"
	"os"
	"strconv"
	"time"
)

func VerifyTraffic(db *sql.DB) {
	for {
		fmt.Println("executing goroutine to update traffic reports...")

		timeString := os.Getenv("CONTEXT_TIME")
		timeValue, err := strconv.Atoi(timeString)

		if err != nil {
			// Handle error
			panic(err)
		}

		contextTime := time.Duration(timeValue) * time.Second

		ctx, cancel := context.WithTimeout(context.Background(), contextTime)
		defer cancel()

		apiService := services.NewApiService(db)
		apiService.UpdateTraffic(ctx)

		fmt.Println("traffic updated.")

		time.Sleep(time.Minute)
	}
}
