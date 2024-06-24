CREATE TABLE IF NOT EXISTS customer (
    uid TEXT PRIMARY KEY,
    created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    email TEXT NOT NULL UNIQUE,
    phone TEXT UNIQUE NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    photo_url TEXT NOT NULL,
    bhc_plot_number TEXT UNIQUE NOT NULL,
    is_existing_customer BOOL NOT NULL
);
