package api

import (
	"encoding/json"
	"errors"
	"log/slog"
	"net/http"
	"strconv"

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
	var reqBody data.OnboardCustomerParams
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

	if reqBody.BhcPlotNumber == "" {
		reqBody.BhcPlotNumber = reqBody.Uid
	}

	dbRes, err := a.db.OnboardCustomer(req.Context(), reqBody)
	if err != nil {
		a.log.Error("failed to onboard customer", slog.String("error_message", err.Error()))
		a.log.Info(reqBody.Uid)
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

func (a *Api) CreateFault(w http.ResponseWriter, req bunrouter.Request) error {
	var reqBody data.CreateFaultParams
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

	dbRes, err := a.db.CreateFault(req.Context(), reqBody)
	if err != nil {
		a.log.Error("failed to add fault", slog.String("error_message", err.Error()))
		a.log.Info(reqBody.CustomerID)
		w.WriteHeader(http.StatusInternalServerError)
		w.Header().Set(contentType, jsonContentType)
		bunrouter.JSON(w, bunrouter.H{
			"message": "failed to add fault",
		})
		return err
	}

	a.log.Info("successfully added fault with id: " + strconv.Itoa(int(dbRes.ID)))
	w.WriteHeader(http.StatusOK)
	w.Header().Set(contentType, jsonContentType)
	bunrouter.JSON(w, dbRes)
	return nil
}

func (a *Api) GetCustomerFaults(w http.ResponseWriter, req bunrouter.Request) error {
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

	dbRes, err := a.db.GetCustomerFaults(req.Context(), uid)
	if err != nil {
		a.log.Error("failed to retrieve faults from database", slog.String("error_message", err.Error()))
		w.WriteHeader(http.StatusInternalServerError)
		w.Header().Set(contentType, jsonContentType)
		bunrouter.JSON(w, bunrouter.H{
			"message":       "failed to retrieve faults with id: " + uid,
			"error_message": err.Error(),
		})
		return err
	}

	a.log.Info("successfully retrieved customer faults with id")
	w.WriteHeader(http.StatusOK)
	w.Header().Set(contentType, jsonContentType)
	bunrouter.JSON(w, dbRes)
	return nil
}
