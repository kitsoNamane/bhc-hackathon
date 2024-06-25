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
    id INTEGER PRIMARY KEY ASC,
    created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    customer_id TEXT NOT NULL,
    description TEXT NOT NULL,
    type TEXT NOT NULL
        CHECK ( type IN('plumbing', 'electrical', 'masonry', 'mechanical', 'carpentry', 'external')),
    incident TEXT NOT NULL,
    plot_number TEXT NOT NULL,
    email TEXT NOT NULL,
    phone TEXT NOT NULL,
    status TEXT NOT NULL
        CHECK ( status IN('open', 'progress', 'closed', 'overdue')),
    severity TEXT NOT NULL
        CHECK ( severity IN('normal', 'urgent', 'emergency')),
    photo_url TEXT NOT NULL
);
