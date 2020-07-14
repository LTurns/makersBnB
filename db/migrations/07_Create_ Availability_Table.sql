CREATE TABLE available_dates(id SERIAL PRIMARY KEY, listing_id INTEGER REFERENCES listings (id), date_start DATE, date_end DATE);
