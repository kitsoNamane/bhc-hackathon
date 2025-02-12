-- name: GetCustomer :one
SELECT uid, email, photo_url, is_existing_customer, phone, first_name, last_name, bhc_plot_number
FROM customer
WHERE uid = ?;

-- name: OnboardCustomer :one
INSERT INTO customer (
    uid, email, photo_url, is_existing_customer, phone, first_name, last_name, bhc_plot_number
) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
RETURNING uid, email, photo_url, is_existing_customer, phone, first_name, last_name, bhc_plot_number;

-- name: GetCustomerFaults :many
SELECT id, created_at, customer_id, description, type, incident, plot_number, email, phone, status, severity, photo_url, payment_status
FROM fault
WHERE customer_id = ?
ORDER BY created_at DESC;

-- name: CreateFault :one
INSERT INTO fault (
    customer_id, description, type, incident, plot_number, email, phone, status, severity, photo_url, fault_occured_at
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
RETURNING id, created_at, fault_occured_at, customer_id, description, type, incident, plot_number, email, phone, status, severity, photo_url, payment_status;

-- name: InitiatePaymentTransaction :one
INSERT INTO payment (
    fault_id, customer_id, client_secret, amount
) VALUES (?, ?, ?, ?)
RETURNING id, created_at, customer_id, fault_id, amount, client_secret, status;

-- name: ProcessPayment :one
UPDATE payment
SET status = ?,
    paid_at = ?
WHERE fault_id = ? AND customer_id = ?
RETURNING id, customer_id, fault_id, status;

-- name: UpdateFaultPaymentStatus :exec
UPDATE fault
    SET payment_status = ?,
    status = ?
WHERE id = ?;

-- name: GetCustomerPayments :many
SELECT id, coalesce(created_at, 'xxx') created_at, customer_id, fault_id, amount, client_secret, status, paid_at
FROM  payment
WHERE customer_id = ?
ORDER BY created_at DESC;
