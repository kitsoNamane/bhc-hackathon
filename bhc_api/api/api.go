package api

import (
	"encoding/json"
	"errors"
	"log/slog"
	"net/http"

	"github.com/google/uuid"
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
		a.log.Error("uuid is required")
		w.WriteHeader(http.StatusBadRequest)
		w.Header().Set(contentType, jsonContentType)
		bunrouter.JSON(w, bunrouter.H{
			"message": "uuid is required",
		})
		return errors.New("uuid is required")
	}

	dbRes, err := a.db.GetCustomer(req.Context(), uid)
	if err != nil {
		a.log.Error("failed to retrieve customer from database", slog.String("error_message", err.Error()))
		w.WriteHeader(http.StatusInternalServerError)
		w.Header().Set(contentType, jsonContentType)
		bunrouter.JSON(w, bunrouter.H{
			"message":       "failed to retrieve customer with id: " + uid,
			"error_message": err.Error(),
		})
		return err
	}

	a.log.Info("successfully retrieved customer with id: " + dbRes.Uid)
	w.WriteHeader(http.StatusOK)
	w.Header().Set(contentType, jsonContentType)
	bunrouter.JSON(w, dbRes)
	return nil
}

func (a *Api) OnboardUser(w http.ResponseWriter, req bunrouter.Request) error {
	var reqBody data.Customer
	err := json.NewDecoder(req.Body).Decode(&reqBody)
	if err != nil {
		a.log.Error("failed to decode json body", slog.String("error_message", err.Error()))
		w.WriteHeader(http.StatusInternalServerError)
		w.Header().Set(contentType, jsonContentType)
		bunrouter.JSON(w, bunrouter.H{
			"message": "failed to decode json body",
		})
		return err
	}

	dbRes, err := a.db.OnboardCustomer(req.Context(),
		data.OnboardCustomerParams{
			Uid:                reqBody.Uid,
			Email:              reqBody.Email,
			Phone:              reqBody.Phone,
			FirstName:          reqBody.FirstName,
			LastName:           reqBody.LastName,
			PhotoUrl:           reqBody.PhotoUrl,
			BhcPlotNumber:      reqBody.BhcPlotNumber,
			IsExistingCustomer: reqBody.IsExistingCustomer,
		},
	)
	if err != nil {
		a.log.Error("failed to onboard customer", slog.String("error_message", err.Error()))
		w.WriteHeader(http.StatusInternalServerError)
		w.Header().Set(contentType, jsonContentType)
		bunrouter.JSON(w, bunrouter.H{
			"message": "failed to onboard customer",
		})
		return err
	}

	a.log.Info("successfully onboarded user with id: " + dbRes.Uid)
	w.WriteHeader(http.StatusOK)
	w.Header().Set(contentType, jsonContentType)
	bunrouter.JSON(w, dbRes)
	return nil
}
