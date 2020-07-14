require 'pg'

p "Setting up database..."

def setup_test_database
  connection = PG.connect(dbname: 'makers_bnb_test')
  connection.exec('TRUNCATE listings, users, pictures, available_dates, bookings;')
end
