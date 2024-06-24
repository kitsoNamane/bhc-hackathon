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
SELECT id, created_at, customer_id, description, type, incident, plot_number, email, phone, status, severity, photo_url
FROM fault
WHERE customer_id = ?
ORDER BY created_at DESC;

-- name: CreateFault :one
INSERT INTO fault (
    customer_id, description, type, incident, plot_number, email, phone, status, severity, photo_url
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
RETURNING id, created_at, customer_id, description, type, incident, plot_number, email, phone, status, severity, photo_url
