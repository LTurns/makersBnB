CREATE TABLE bookings (
	id SERIAL PRIMARY KEY,
	listing_id INTEGER REFERENCES listings (id),
	user_id INTEGER REFERENCES users (id),
	book_from DATE,
	book_to DATE
);
