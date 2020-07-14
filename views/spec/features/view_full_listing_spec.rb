require 'database_helpers'

feature 'Viewing the full listing' do
  scenario 'User clicks view button' do
    user_sign_in
    listing = Listing.create(name: "House of Horrors", description: "A very scary house", price: "69.85")

    visit '/'

    expect(page).to have_content "House of Horrors A very scary house 69.85"

    first('.listing').click_button 'View'

    expect(current_path).to eq "/listings/#{listing.id}/show"

    expect(page).to have_content "House of Horrors"
    expect(page).to have_content "A very scary house"
    expect(page).to have_content "69.85"
  end

  scenario "Click back to full listings" do 
    user_sign_in
    listing = Listing.create(name: "House of Horrors", description: "A very scary house", price: "69.85")

    visit '/'

    first('.listing').click_button 'View'

    expect(current_path).to eq "/listings/#{listing.id}/show"

    expect(page).to have_button "Home"
    click_button "Home"
    expect(current_path).to eq "/"
  end 
end
