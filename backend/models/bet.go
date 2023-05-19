package models

import (
	"time"
)

type Bet struct {
	ID        int       `db:"id"`
	Title     string    `db:"title"`
	Type      int       `db:"type"`
	DateBet   time.Time `db:"date_bet"`
	LimitDate time.Time `db:"limit_date"`
	QtVictory float64   `db:"qt_victory"`
	QtLoss    float64   `db:"qt_loss"`
	Status    string    `db:"status"`
	UserID    int64     `db:"user_id"`
	Created   time.Time `db:"created"`
}

type Ticket struct {
	ID     int     `db:"id"`
	UserID int     `db:"user_id"`
	BetID  int     `db:"bet_id"`
	Bid    bool    `db:"bid"`
	Value  float64 `db:"value"`
	Status string  `db:"status"`
}
