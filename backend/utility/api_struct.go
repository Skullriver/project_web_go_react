package utility

type ApiResponse struct {
	Pagination struct {
		StartPage    int `json:"start_page"`
		ItemsOnPage  int `json:"items_on_page"`
		ItemsPerPage int `json:"items_per_page"`
		TotalResult  int `json:"total_result"`
	} `json:"pagination"`
	Links []struct {
		Href      string `json:"href"`
		Type      string `json:"type"`
		Rel       string `json:"rel,omitempty"`
		Templated bool   `json:"templated"`
	} `json:"links"`
	Warnings []struct {
		Message string `json:"message"`
		ID      string `json:"id"`
	} `json:"warnings"`
	Disruptions []struct {
		Status   string `json:"status"`
		Category string `json:"category"`
		Severity struct {
			Color    string `json:"color"`
			Priority int    `json:"priority"`
			Name     string `json:"name"`
			Effect   string `json:"effect"`
		} `json:"severity"`
		Tags               []string `json:"tags"`
		Cause              string   `json:"cause"`
		ApplicationPeriods []struct {
			Begin string `json:"begin"`
			End   string `json:"end"`
		} `json:"application_periods"`
		ImpactID string `json:"impact_id"`
		Messages []struct {
			Text    string `json:"text"`
			Channel struct {
				ContentType string   `json:"content_type"`
				ID          string   `json:"id"`
				Types       []string `json:"types"`
				Name        string   `json:"name"`
			} `json:"channel"`
		} `json:"messages"`
		UpdatedAt       string `json:"updated_at"`
		URI             string `json:"uri"`
		ImpactedObjects []struct {
			PtObject struct {
				EmbeddedType string `json:"embedded_type"`
				Line         struct {
					Code    string `json:"code"`
					Name    string `json:"name"`
					Links   []any  `json:"links"`
					Color   string `json:"color"`
					Geojson struct {
						Type        string `json:"type"`
						Coordinates []any  `json:"coordinates"`
					} `json:"geojson"`
					TextColor     string `json:"text_color"`
					PhysicalModes []struct {
						ID   string `json:"id"`
						Name string `json:"name"`
					} `json:"physical_modes"`
					Codes []struct {
						Type  string `json:"type"`
						Value string `json:"value"`
					} `json:"codes"`
					ClosingTime    string `json:"closing_time"`
					OpeningTime    string `json:"opening_time"`
					CommercialMode struct {
						ID   string `json:"id"`
						Name string `json:"name"`
					} `json:"commercial_mode"`
					ID string `json:"id"`
				} `json:"line"`
				Quality int    `json:"quality"`
				Name    string `json:"name"`
				ID      string `json:"id"`
			} `json:"pt_object"`
		} `json:"impacted_objects"`
		ID                  string `json:"id"`
		DisruptionURI       string `json:"disruption_uri"`
		Contributor         string `json:"contributor"`
		ApplicationPatterns []struct {
			WeekPattern struct {
				Monday    bool `json:"monday"`
				Tuesday   bool `json:"tuesday"`
				Friday    bool `json:"friday"`
				Wednesday bool `json:"wednesday"`
				Thursday  bool `json:"thursday"`
				Sunday    bool `json:"sunday"`
				Saturday  bool `json:"saturday"`
			} `json:"week_pattern"`
			ApplicationPeriod struct {
				Begin string `json:"begin"`
				End   string `json:"end"`
			} `json:"application_period"`
			TimeSlots []struct {
				Begin string `json:"begin"`
				End   string `json:"end"`
			} `json:"time_slots"`
		} `json:"application_patterns,omitempty"`
		DisruptionID string `json:"disruption_id"`
	} `json:"disruptions"`
	LineReports []struct {
		Line struct {
			Code    string `json:"code"`
			Name    string `json:"name"`
			Links   []any  `json:"links"`
			Color   string `json:"color"`
			Geojson struct {
				Type        string `json:"type"`
				Coordinates []any  `json:"coordinates"`
			} `json:"geojson"`
			TextColor     string `json:"text_color"`
			PhysicalModes []struct {
				ID   string `json:"id"`
				Name string `json:"name"`
			} `json:"physical_modes"`
			Codes []struct {
				Type  string `json:"type"`
				Value string `json:"value"`
			} `json:"codes"`
			ClosingTime    string `json:"closing_time"`
			OpeningTime    string `json:"opening_time"`
			CommercialMode struct {
				ID   string `json:"id"`
				Name string `json:"name"`
			} `json:"commercial_mode"`
			ID string `json:"id"`
		} `json:"line"`
		PtObjects []struct {
			EmbeddedType string `json:"embedded_type"`
			StopArea     struct {
				Codes []struct {
					Type  string `json:"type"`
					Value string `json:"value"`
				} `json:"codes"`
				Name  string `json:"name"`
				Links []struct {
					Internal  bool   `json:"internal"`
					Type      string `json:"type"`
					ID        string `json:"id"`
					Rel       string `json:"rel"`
					Templated bool   `json:"templated"`
				} `json:"links"`
				Coord struct {
					Lat string `json:"lat"`
					Lon string `json:"lon"`
				} `json:"coord"`
				Label    string `json:"label"`
				Timezone string `json:"timezone"`
				ID       string `json:"id"`
			} `json:"stop_area"`
			Quality int    `json:"quality"`
			Name    string `json:"name"`
			ID      string `json:"id"`
		} `json:"pt_objects"`
	} `json:"line_reports"`
	FeedPublishers []struct {
		URL     string `json:"url"`
		ID      string `json:"id"`
		License string `json:"license"`
		Name    string `json:"name"`
	} `json:"feed_publishers"`
	Context struct {
		Timezone        string `json:"timezone"`
		CurrentDatetime string `json:"current_datetime"`
	} `json:"context"`
}
