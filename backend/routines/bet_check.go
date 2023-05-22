package routines

import (
	"context"
	"database/sql"
	"github.com/Skullriver/Sorbonne_PS3R.git/services"
	"time"
)

func VerifyBet(db *sql.DB, ctx context.Context) {

	for {
		// Calculate the duration until the next 3 am
		durationUntilNext3AM := calculateDurationUntilNext3AM()

		// Sleep until the next 3 am
		time.Sleep(durationUntilNext3AM)

		betService := services.NewBetService(db)
		betService.CheckBets(ctx)

	}

}

func calculateDurationUntilNext3AM() time.Duration {

	location, err := time.LoadLocation("Europe/Paris")
	if err != nil {
		// Handle error
		return 0
	}
	now := time.Now().In(location)
	desiredTime := time.Date(now.Year(), now.Month(), now.Day(), 3, 0, 0, 0, now.Location())
	if now.After(desiredTime) {
		// If it's already past 3 am, calculate the duration until tomorrow's 3 am
		desiredTime = desiredTime.Add(24 * time.Hour)
	}
	durationUntilNext3AM := desiredTime.Sub(now)
	return durationUntilNext3AM
}
