package api

import (
	"encoding/json"
	"errors"
	"log/slog"
	"net/http"
	"strconv"

	"github.com/kitsoNamane/bhc_api/data"
	"github.com/stripe/stripe-go/v79"
	"github.com/stripe/stripe-go/v79/paymentintent"
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

func (a *Api) StartPaymentTransaction(w http.ResponseWriter, req bunrouter.Request) error {
	var reqBody data.InitiatePaymentTransactionParams
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

	stripe.Key = "sk_test_51MLa6YG4sSRlNRRrFc2P0OH0SEAtrkaAQuUbnyHE9Ud9VqvgVqHBCwvVzv49OfYBIuW6eIrSZcKtRD5LE0w5teh200Sf9Sgiii"
	params := &stripe.PaymentIntentParams{
		Amount:        stripe.Int64(reqBody.Amount),
		Currency:      stripe.String(string(stripe.CurrencyBWP)),
		PaymentMethod: stripe.String("pm_card_visa"),
	}

	result, err := paymentintent.New(params)
	if err != nil {
		a.log.Error("failed to create payment intent", slog.String("error_message", err.Error()))
		w.WriteHeader(http.StatusInternalServerError)
		w.Header().Set(contentType, jsonContentType)
		bunrouter.JSON(w, bunrouter.H{
			"message": "failed to create payment intent",
		})
		return err
	}

	reqBody.ClientSecret = result.ClientSecret
	dbRes, err := a.db.InitiatePaymentTransaction(req.Context(), reqBody)
	if err != nil {
		a.log.Error("failed to add fault", slog.String("error_message", err.Error()))
		w.WriteHeader(http.StatusInternalServerError)
		w.Header().Set(contentType, jsonContentType)
		bunrouter.JSON(w, bunrouter.H{
			"message": "failed to add fault",
		})
		return err
	}

	a.log.Info("successfully initiated a payment transaction")
	w.WriteHeader(http.StatusOK)
	w.Header().Set(contentType, jsonContentType)
	bunrouter.JSON(w, dbRes)
	return nil
}

func (a *Api) CompletePaymentTransaction(w http.ResponseWriter, req bunrouter.Request) error {
	var reqBody data.ProcessPaymentParams
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

	payment, err := a.db.ProcessPayment(req.Context(), reqBody)
	if err != nil {
		a.log.Error("failed to add fault", slog.String("error_message", err.Error()))
		a.log.Info(reqBody.CustomerID)
		w.WriteHeader(http.StatusInternalServerError)
		w.Header().Set(contentType, jsonContentType)
		bunrouter.JSON(w, payment)
		return err
	}

	if reqBody.Status == "cancelled" || reqBody.Status == "failed" {
		a.log.Info("successfully updated payment", slog.String("payment_status", reqBody.Status))
		w.WriteHeader(http.StatusOK)
		w.Header().Set(contentType, jsonContentType)
		bunrouter.JSON(w, payment)
		return nil

	}

	err = a.db.UpdateFaultPaymentStatus(req.Context(), data.UpdateFaultPaymentStatusParams{
		ID:            reqBody.FaultID,
		Status:        "closed",
		PaymentStatus: "paid",
	})
	if err != nil {
		a.log.Error("failed to update fault payment status", slog.String("error_message", err.Error()))
		a.log.Info(reqBody.CustomerID)
		w.WriteHeader(http.StatusInternalServerError)
		w.Header().Set(contentType, jsonContentType)
		bunrouter.JSON(w, payment)
		return err
	}

	a.log.Info("successfully updated payment")
	w.WriteHeader(http.StatusOK)
	w.Header().Set(contentType, jsonContentType)
	bunrouter.JSON(w, payment)
	return nil
}

func (a *Api) GetCustomerPayments(w http.ResponseWriter, req bunrouter.Request) error {
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

	dbRes, err := a.db.GetCustomerPayments(req.Context(), uid)
	if err != nil {
		a.log.Error("failed to retrieve payments from database", slog.String("error_message", err.Error()))
		w.WriteHeader(http.StatusInternalServerError)
		w.Header().Set(contentType, jsonContentType)
		bunrouter.JSON(w, bunrouter.H{
			"message":       "failed to retrieve payments with id: " + uid,
			"error_message": err.Error(),
		})
		return err
	}

	a.log.Info("successfully retrieved customer payments")
	w.WriteHeader(http.StatusOK)
	w.Header().Set(contentType, jsonContentType)
	bunrouter.JSON(w, dbRes)
	return nil
}
