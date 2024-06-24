-- name: GetCustomer :one
SELECT uid, email, photo_url, is_existing_customer, phone, first_name, last_name, bhc_plot_number
FROM customer
WHERE uid = ?;

-- name: OnboardCustomer :one
INSERT INTO customer (
    uid, email, photo_url, is_existing_customer, phone, first_name, last_name, bhc_plot_number
) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
RETURNING uid, email, photo_url, is_existing_customer, phone, first_name, last_name, bhc_plot_number;
