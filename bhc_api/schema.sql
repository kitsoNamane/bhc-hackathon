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

CREATE TABLE IF NOT EXISTS fault (
    id INTEGER PRIMARY KEY DEFAULT random(),
    created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    customer_id TEXT NOT NULL,
    description TEXT NOT NULL,
    type TEXT NOT NULL,
    plot_number TEXT NOT NULL,
    email TEXT NOT NULL,
    phone TEXT NOT NULL,
    status TEXT NOT NULL,
    CHECK ( status IN("open", "progress", "closed"))
);
