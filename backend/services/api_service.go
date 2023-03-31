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
	LineRepository       repository.LineRepository
	DisruptionRepository repository.DisruptionRepository
}

func NewApiService(db *sql.DB) *ApiService {
	return &ApiService{
		LineRepository:       repository.NewPostgresLineRepository(db),
		DisruptionRepository: repository.NewPostgresDisruptionRepository(db),
	}
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

func getDisruptionsMap(response utility.ApiResponse) map[string]*models.Disruption {

	// Create a map with string keys and int values
	disruptionsMap := make(map[string]*models.Disruption)

	for _, disruption := range response.Disruptions {

		if disruption.Cause == "travaux" {
			continue
		}

		title := ""
		text := ""
		for _, message := range disruption.Messages {
			if message.Channel.Name == "titre" {
				title = message.Text
			}
			if message.Channel.Name == "moteur" {
				text = message.Text
			}
		}

		layout := "20060102T150405"

		updatedTime, err := time.Parse(layout, disruption.UpdatedAt)
		if err != nil {
			fmt.Println("Error parsing UpdatedAt time:", err)
			return nil
		}

		applicationStartTime, err := time.Parse(layout, disruption.ApplicationPeriods[0].Begin)
		if err != nil {
			fmt.Println("Error parsing application period begin time:", err)
			return nil
		}
		applicationEndTime, err := time.Parse(layout, disruption.ApplicationPeriods[0].End)
		if err != nil {
			fmt.Println("Error parsing application period end time:", err)
			return nil
		}

		disruptionObj := &models.Disruption{
			DisruptionID:     disruption.ID,
			Status:           disruption.Status,
			Type:             disruption.Cause,
			Color:            disruption.Severity.Color,
			Effect:           disruption.Severity.Effect,
			Title:            title,
			Message:          text,
			UpdatedAt:        updatedTime,
			ApplicationStart: applicationStartTime,
			ApplicationEnd:   applicationEndTime,
		}

		disruptionsMap[disruption.ID] = disruptionObj
	}

	return disruptionsMap
}

func (s *ApiService) UpdateTraffic(ctx context.Context) {

	response := SendRequest()

	disruptions := getDisruptionsMap(response)

	for _, lineReport := range response.LineReports {
		//Get line object
		line := lineReport.Line

		// Check if a line already exists
		dbLine, err := s.LineRepository.GetLineByLineID(ctx, line.ID)

		if err != nil && err != repository.ErrNoLine {
			return
		}
		//Create new Line
		if err == repository.ErrNoLine {
			layout := "150405"
			closingTime, er := time.Parse(layout, line.ClosingTime)
			if er != nil {
				fmt.Println("Error parsing closing time:", er)
				return
			}
			openingTime, er := time.Parse(layout, line.OpeningTime)
			if er != nil {
				fmt.Println("Error parsing closing time:", er)
				return
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

			// Create a new line with the received parameters
			_, er = s.LineRepository.CreateLine(ctx, dbLine)
			if er != nil {
				fmt.Println("Error creating line:", er)
				return
			}

		}

		//Create new Disruption
		if dbLine.ID != 0 && disruptions != nil {
			for _, link := range line.Links {

				linkMap, ok := link.(map[string]interface{})
				if !ok {
					// handle the case where the link is not a map
					continue
				}
				var linkObj utility.Link
				linkObj.ID = linkMap["id"].(string)
				linkObj.Internal = linkMap["internal"].(bool)
				linkObj.Rel = linkMap["rel"].(string)
				linkObj.Templated = linkMap["templated"].(bool)
				linkObj.Type = linkMap["type"].(string)

				// Check if id key exists in disruptionsMap
				disruption, exists := disruptions[linkObj.ID]
				if exists {

					// Check if disruption exists in database
					_, er := s.DisruptionRepository.GetDisruptionByDisruptionID(ctx, disruption.DisruptionID)

					if er != nil && er != repository.ErrNoDisruption {
						return
					}

					if er == repository.ErrNoDisruption {
						_, e := s.DisruptionRepository.CreateDisruption(ctx, disruption)
						if e != nil {
							fmt.Println("Error creating line:", er)
							return
						}
					}
				}
			}
		}

	}

}
