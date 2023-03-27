package services

import (
    "context"
    "log"
    "errors"
    "time"
    "github.com/Skullriver/Sorbonne_PS3R.git/models"
    "github.com/Skullriver/Sorbonne_PS3R.git/repository"
    "github.com/dgrijalva/jwt-go"
)

type AuthService struct {
    UserRepository repository.UserRepository
    TokenSecret     string
    TokenLifetime   time.Duration
}

func (s *AuthService) RegisterUser(ctx context.Context, email, password, username string) error {
    // Check if a user with the same email already exists
    user, err := s.UserRepository.GetUserByEmail(ctx, email)
    if err == nil {
        return errors.New("user already exists")
    }

    // If GetUserByEmail returned an error other than ErrNoUser, return the error
    if err != repository.ErrNoUser {
        return err
    }

    // Create a new user with the given email, password, and username
    user = &models.User{Email: email, Password: password, Username: username}
    err = s.UserRepository.CreateUser(ctx, user)
    if err != nil {
        return err
    }

    return nil
}

func (s *AuthService) LoginUser(ctx context.Context, email, password string) (string, error) {
    // Check if user with given email exists
    log.Printf("UserRepository: %+v\n", s.UserRepository)
    user, err := s.UserRepository.GetUserByEmail(ctx, email)
    if err != nil {
        return "", errors.New("invalid email or password")
    }

    // Check if the password is correct
    if !user.CheckPassword(password) {
        return "", errors.New("invalid email or password")
    }

    // Generate JWT token
    token, err := s.generateToken(user.ID)
    if err != nil {
        return "", err
    }

    return token, nil
}

func (s *AuthService) VerifyToken(ctx context.Context, tokenString string) (int64, error) {
    // TODO: implement JWT token verification
    return 0, errors.New("not implemented")
}

func (s *AuthService) GetUserByID(ctx context.Context, userID int64) (*models.User, error) {
    // TODO: implement getting user by ID from the database
    return nil, errors.New("not implemented")
}

func (s *AuthService) UpdateUserPassword(ctx context.Context, userID int64, newPassword string) error {
    // TODO: implement updating user password in the database
    return errors.New("not implemented")
}

func (s *AuthService) generateToken(userID int64) (string, error) {
    // Create a new JWT token with a custom claim containing the user ID
    token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
        "userID": userID,
        "exp":    time.Now().Add(s.TokenLifetime).Unix(),
    })

    // Sign the token using the secret key
    tokenString, err := token.SignedString([]byte(s.TokenSecret))
    if err != nil {
        return "", err
    }

    return tokenString, nil
}

func (s *AuthService) parseToken(tokenString string) (*jwt.Token, error) {
    // TODO: implement JWT token parsing
    return nil, errors.New("not implemented")
}

func (s *AuthService) getTokenExpirationTime() time.Time {
    return time.Now().Add(s.TokenLifetime)
}
