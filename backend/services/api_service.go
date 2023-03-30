package services

import (
	"context"
	"database/sql"
	"encoding/json"
	"fmt"
	"github.com/Skullriver/Sorbonne_PS3R.git/models"
	"github.com/Skullriver/Sorbonne_PS3R.git/repository"
	"github.com/Skullriver/Sorbonne_PS3R.git/utility"
	"io/ioutil"
	"net/http"
	"time"
)

type ApiService struct {
	TrafficRepository repository.TrafficRepository
}

func NewApiService(db *sql.DB) *ApiService {
	return &ApiService{TrafficRepository: repository.NewPostgresTrafficRepository(db)}
}

func SendRequest() utility.ApiResponse {
	// Create a new request object
	req, err := http.NewRequest("GET", "https://prim.iledefrance-mobilites.fr/marketplace/navitia/line_reports/coverage/fr-idf/physical_modes/physical_mode:Metro/line_reports", nil)
	if err != nil {
		fmt.Println("Error occurred while creating request:", err)
		return utility.ApiResponse{}
	}

	// Set the headers
	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("apikey", "a8SDNPE2z2D8fUQEa3ueGFycxqjnwD9I")

	// Make the request
	client := &http.Client{}
	response, err := client.Do(req)
	if err != nil {
		fmt.Println("Error occurred while making API request:", err)
		return utility.ApiResponse{}
	}

	// Read the response body
	defer response.Body.Close()
	responseBody, err := ioutil.ReadAll(response.Body)
	if err != nil {
		fmt.Println("Error occurred while reading API response:", err)
		return utility.ApiResponse{}
	}

	// Parse the response body into a ApiResponse struct
	var parsedResponse utility.ApiResponse
	err = json.Unmarshal(responseBody, &parsedResponse)
	if err != nil {
		fmt.Println("Error occurred while parsing API response:", err)
		return utility.ApiResponse{}
	}

	return parsedResponse
}

func (s *ApiService) UpdateTraffic(ctx context.Context) utility.ApiResponse {

	response := SendRequest()

	for _, lineReport := range response.LineReports {
		//Get line object
		line := lineReport.Line

		// Check if a line already exists
		dbLine, err := s.TrafficRepository.GetLineByLineID(ctx, line.ID)

		if err != repository.ErrNoLine {
			return utility.ApiResponse{}
		}
		//Create new Line
		if err == repository.ErrNoLine {
			layout := "150405"
			closingTime, er := time.Parse(layout, line.ClosingTime)
			if er != nil {
				fmt.Println("Error parsing closing time:", err)
				return utility.ApiResponse{}
			}
			openingTime, er := time.Parse(layout, line.OpeningTime)
			if er != nil {
				fmt.Println("Error parsing closing time:", err)
				return utility.ApiResponse{}
			}

			dbLine = &models.Line{
				LineID:      line.ID,
				Code:        line.Code,
				Name:        line.Name,
				Color:       line.Color,
				TextColor:   line.TextColor,
				ClosingTime: closingTime,
				OpeningTime: openingTime,
			}

			// Create a new user with the given email, password, and username
			_, er = s.TrafficRepository.CreateLine(ctx, dbLine)
			if er != nil {
				fmt.Println("Error creating line:", er)
				return utility.ApiResponse{}
			}

		}

	}

	return response
}
