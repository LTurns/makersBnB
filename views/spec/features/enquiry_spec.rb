require 'database_helpers'

feature 'enables user to make enquiry' do
  scenario 'user inputs text and enquiry is sent to listing owner' do
    user = User.create(username: 'LTURNS', email: 'lizzieturney@gmail.com', password: 'Hello')
    authenticated_user = User.authenticate(username: 'LTURNS',password: 'Hello')

    listing = Listing.create(name: "House of Horrors", description: "A very scary house", price: "69.85")
    Available_Dates.create(listing_id: listing.id, date_start: '2020-05-04' , date_end: '2020-05-05');
    visit('/')
    click_button('Sign Out')

    user = User.create(username: 'Unicorn', email: 'collj035@gmail.com', password: '1234')
    authenticated_user = User.authenticate(username: 'Unicorn',password: '1234')
    visit("/listings/#{listing.id}/show")

    expect(page).to have_button "Enquiry"

    click_button "Enquiry"

    expect(current_path).to eq "/listings/#{listing.id}/enquiry"
    expect(page).to have_field "body"
    expect(page).to have_field "subject_line"
    expect(page).to have_button "Submit"
    expect(current_path).to eq "/listings/enquiry_confirmation"
    expect(page).to have_css 'a[href="mailto:lizzieturney@gmail.com"]'
  end
end
