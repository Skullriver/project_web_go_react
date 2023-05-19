package services

import (
	"context"
	"github.com/Skullriver/Sorbonne_PS3R.git/repository"
	"github.com/Skullriver/Sorbonne_PS3R.git/utility"
	"time"
)

type TrafficService struct {
	UserRepository       repository.UserRepository
	LineRepository       repository.LineRepository
	DisruptionRepository repository.DisruptionRepository
	LogRepository        repository.LogRepository
}

func (s *TrafficService) GetTraffic(ctx context.Context, dateStart string, dateEnd string) utility.TrafficResponse {

	dateS, err := time.Parse("02012006", dateStart)
	if err != nil {
		return nil
	}
	dateE, err := time.Parse("02012006", dateEnd)
	if err != nil {
		return nil
	}
	dateE = dateE.AddDate(0, 0, 1)

	lines, err := s.LineRepository.GetLines(ctx)
	if err != nil {
		return nil
	}
	disruptions, err := s.DisruptionRepository.GetDisruptionsMap(ctx, dateS, dateE)
	if err != nil {
		return nil
	}

	response := utility.TrafficResponse{}

	for _, line := range lines {

		disruptionList, exists := disruptions[line.LineID]
		var disruptionsObj []utility.Disruptions
		lineObj := utility.Line{}

		lineObj.ID = line.ID
		lineObj.Code = line.Code
		lineObj.Name = line.Name
		lineObj.Color = "#" + line.Color
		lineObj.TextColor = "#" + line.TextColor
		lineObj.PhysicalMode = line.PhysicalMode
		lineObj.ClosingTime = line.ClosingTime.Format("15:04")
		lineObj.OpeningTime = line.OpeningTime.Format("15:04")
		lineObj.Disruptions = disruptionsObj

		if exists {
			for _, disruption := range disruptionList {
				messageObj := utility.Message{}
				messageObj.Title = disruption.Title
				messageObj.Description = disruption.Message

				disruptionObj := utility.Disruptions{}
				disruptionObj.ID = disruption.DisruptionID
				disruptionObj.Effect = disruption.Effect
				disruptionObj.Color = disruption.Color
				disruptionObj.Message = messageObj
				disruptionObj.UpdatedAt = disruption.UpdatedAt.Format("02/01/2006 15:04:05")
				disruptionObj.CreatedAt = disruption.CreatedAt.Format("02/01/2006 15:04:05")
				disruptionObj.ApplicationStart = disruption.ApplicationStart.Format("02/01/2006 15:04:05")
				disruptionObj.ApplicationEnd = disruption.ApplicationEnd.Format("02/01/2006 15:04:05")

				disruptionsObj = append(disruptionsObj, disruptionObj)
			}
			lineObj.Disruptions = disruptionsObj

		}
		response = append(response, struct {
			Line utility.Line `json:"line"`
		}{
			Line: lineObj,
		})
	}

	return response
}
