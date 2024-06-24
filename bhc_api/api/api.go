package api

import (
	"encoding/json"
	"errors"
	"log/slog"
	"net/http"

	"github.com/kitsoNamane/bhc_api/data"
	"github.com/uptrace/bunrouter"
)

const (
	contentType     = "Content-Type"
	jsonContentType = "application/json"
)

type Api struct {
	db  *data.Queries
	log *slog.Logger
}

type ApiResponse struct {
}

func NewApi(db *data.Queries, log *slog.Logger) *Api {
	return &Api{db: db, log: log}
}

func (a *Api) GetUser(w http.ResponseWriter, req bunrouter.Request) error {
	uid := req.URL.Query().Get("uuid")
	if uid == "" {
		w.WriteHeader(http.StatusBadRequest)
		w.Header().Set(contentType, jsonContentType)
		bunrouter.JSON(w, bunrouter.H{
			"message": "uuid is required",
		})
		return errors.New("uuid is required")
	}

	dbRes, err := a.db.GetCustomer(req.Context(), uid)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		w.Header().Set(contentType, jsonContentType)
		bunrouter.JSON(w, bunrouter.H{
			"message":       "failed to retrieve customer with id: " + uid,
			"error_message": err.Error(),
		})
		return err
	}

	w.WriteHeader(http.StatusOK)
	w.Header().Set(contentType, jsonContentType)
	bunrouter.JSON(w, dbRes)
	return nil
}

func (a *Api) OnboardUser(w http.ResponseWriter, req bunrouter.Request) error {
	type r struct {
		Uuid               string `json:"uuid"`
		Email              string `json:"email"`
		Phone              string `json:"phone"`
		FirstName          string `json:"first_name"`
		LastName           string `json:"last_name"`
		PhotoUrl           string `json:"photo_url"`
		BHCPlotNumber      string `json:"bhc_plot_number"`
		IsExistingCustomer bool   `json:"is_existing_customer"`
	}

	var reqBody data.OnboardCustomerParams

	err := json.NewDecoder(req.Body).Decode(&reqBody)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		w.Header().Set(contentType, jsonContentType)
		bunrouter.JSON(w, bunrouter.H{
			"message": "failed to decode json body",
		})
		return err
	}

	dbRes, err := a.db.OnboardCustomer(req.Context(), reqBody)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		w.Header().Set(contentType, jsonContentType)
		bunrouter.JSON(w, bunrouter.H{
			"message": "failed to onboard customer",
		})
		return err
	}

	w.WriteHeader(http.StatusOK)
	w.Header().Set(contentType, jsonContentType)
	bunrouter.JSON(w, dbRes)
	return nil
}
