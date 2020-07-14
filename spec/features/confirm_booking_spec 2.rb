require 'database_helpers'

feature 'Booking Confirmation' do
scenario 'user can see their booking dates' do
  user_sign_in
  listing = Listing.create(name: "House of Horrors", description: "A very scary house", price: "69.85")
  Available_Dates.create(listing_id: listing.id, date_start: '2020-05-04' , date_end: '2020-05-05');
  visit("/booking/#{listing.id}/book")

  Booking.create(listing_id: "#{listing.id}", user_id: "#{User.current_user.id}", book_from: "2020-05-04", book_to: "2020-05-05")
  expect(page).to have_button "Submit"
  click_button "Submit"
  expect(current_path).to eq "/booking/confirmation"
  expect(page).to have_content "You have booked the following..."
 end
end
