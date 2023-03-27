package repository

import (
    "context"
    "database/sql"
    "fmt"
	"errors"
    "github.com/Skullriver/Sorbonne_PS3R.git/models"
)

var ErrNoUser = errors.New("no user found")

type UserRepository interface {
    CreateUser(ctx context.Context, user *models.User) error
    GetUserByID(ctx context.Context, id int64) (*models.User, error)
    GetUserByEmail(ctx context.Context, email string) (*models.User, error)
    UpdateUser(ctx context.Context, user *models.User) error
    DeleteUser(ctx context.Context, id int64) error
}

type postgresUserRepository struct {
    db *sql.DB
}

func NewPostgresUserRepository(db *sql.DB) UserRepository {
    return &postgresUserRepository{db: db}
}

func (r *postgresUserRepository) CreateUser(ctx context.Context, user *models.User) error {
    query := "INSERT INTO users (username, email, password, account_balance) VALUES ($1, $2, $3, $4) RETURNING id"
    row := r.db.QueryRowContext(ctx, query, user.Username, user.Email, user.Password, user.AccountBalance)
    err := row.Scan(&user.ID)
    if err != nil {
        return fmt.Errorf("failed to create user: %v", err)
    }
    return nil
}

func (r *postgresUserRepository) GetUserByID(ctx context.Context, id int64) (*models.User, error) {
    query := "SELECT id, username, email, password, account_balance FROM users WHERE id = $1"
    row := r.db.QueryRowContext(ctx, query, id)
    user := &models.User{}
    err := row.Scan(&user.ID, &user.Username, &user.Email, &user.Password, &user.AccountBalance)
    if err == sql.ErrNoRows {
        return nil, fmt.Errorf("no user found")
    }
    if err != nil {
        return nil, fmt.Errorf("failed to get user: %v", err)
    }
    return user, nil
}

func (r *postgresUserRepository) GetUserByEmail(ctx context.Context, email string) (*models.User, error) {
    query := "SELECT id, username, email, password, account_balance FROM users WHERE email = $1"
    row := r.db.QueryRowContext(ctx, query, email)
    user := &models.User{}
    err := row.Scan(&user.ID, &user.Username, &user.Email, &user.Password, &user.AccountBalance)
    if err == sql.ErrNoRows {
        return nil, ErrNoUser
    }
    if err != nil {
        return nil, fmt.Errorf("failed to get user: %v", err)
    }
    return user, nil
}

func (r *postgresUserRepository) UpdateUser(ctx context.Context, user *models.User) error {
    query := "UPDATE users SET username = $1, email = $2, password = $3, account_balance = $4 WHERE id = $5"
    _, err := r.db.ExecContext(ctx, query, user.Username, user.Email, user.Password, user.AccountBalance, user.ID)
    if err != nil {
        return fmt.Errorf("failed to update user: %v", err)
    }
    return nil
}

func (r *postgresUserRepository) DeleteUser(ctx context.Context, id int64) error {
    query := "DELETE FROM users WHERE id = $1"
    _, err := r.db.ExecContext(ctx, query, id)
    if err != nil {
        return fmt.Errorf("failed to delete user: %v", err)
    }
    return nil
}
