package services

import (
	"context"
	"github.com/Skullriver/Sorbonne_PS3R.git/repository"
	"github.com/Skullriver/Sorbonne_PS3R.git/utility"
)

type BetService struct {
	UserRepository       repository.UserRepository
	LineRepository       repository.LineRepository
	DisruptionRepository repository.DisruptionRepository
	LogRepository        repository.LogRepository
}

func (s *BetService) GetInfoForCreation(ctx context.Context) utility.BetCreationResponse {

	lines, err := s.LineRepository.GetLines(ctx)
	if err != nil {
		return utility.BetCreationResponse{}
	}

	var rerList []utility.SimpleLine
	var metroList []utility.SimpleLine

	for _, line := range lines {

		lineObj := utility.SimpleLine{}

		lineObj.Name = line.Code
		lineObj.ClosingTime = line.ClosingTime
		lineObj.OpeningTime = line.OpeningTime

		if line.PhysicalMode == "physical_mode:Metro" {
			metroList = append(metroList, lineObj)
		} else {
			rerList = append(rerList, lineObj)
		}

	}

	response := utility.BetCreationResponse{
		Rer:   rerList,
		Metro: metroList,
	}

	return response
}
