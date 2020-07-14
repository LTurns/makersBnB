require 'booking'
require 'database_helpers'

describe Booking do
  it 'lets you create a booking' do
    user_sign_in
    listing = Listing.create(name: 'Minerva', description: 'A really fun place on the surface of the sun', price: '25.00')
    available = Available_Dates.create(listing_id: "#{listing.id}", date_start: "2020-05-04", date_end: "2020-05-10")
    booking = Booking.create(listing_id: "#{listing.id}", user_id: "#{User.current_user.id}", book_from: "2020-05-04", book_to: "2020-05-05")

    expect(listing.id).to eq booking.listing_id
    expect(booking.book_from).to eq "2020-05-04"
    expect(booking.book_to).to eq "2020-05-05"
  end
end
