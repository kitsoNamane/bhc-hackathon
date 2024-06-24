CREATE TABLE IF NOT EXISTS customer (
    uid TEXT PRIMARY KEY,
    created_at DATE DEFAULT CURRENT_TIMESTAMP,
    email TEXT NOT NULL UNIQUE,
    phone TEXT UNIQUE,
    first_name TEXT,
    last_name TEXT,
    photo_url TEXT,
    bhc_plot_number TEXT UNIQUE,
    is_existing_customer BOOL
);
