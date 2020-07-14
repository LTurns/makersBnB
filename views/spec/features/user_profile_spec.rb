require 'database_helpers'

feature 'User profile page' do
  scenario 'a user can visit his profile page' do
    user_sign_in
    listing = Listing.create(name: 'Village House', description: 'Lovely cottage in the countryside', price: '50.00')
    Picture.create(url: 'https://live.staticflickr.com/4159/33385628794_b912df519b_m.jpg', listing_id: "#{listing.id}")

    visit '/'

    click_link 'My Account'
    expect(current_path).to eq "/users/#{User.current_user.username}/user"

    expect(page).to have_content 'username'
    expect(page).to have_content 'email@email.com'
    expect(page).to have_content 'Village House'
    expect(page).to have_content 'Lovely cottage in the countryside'
    expect(page).to have_css "img[src='https://live.staticflickr.com/4159/33385628794_b912df519b_m.jpg']"

    click_button('Home')

    expect(page).to have_content 'Welcome to MakersBnB'
  end

  scenario 'a user can update his own listings' do
    user_sign_in
    listing = Listing.create(name: 'Village House', description: 'Lovely cottage in the countryside', price: '50.00')
    Picture.create(url: 'https://live.staticflickr.com/4159/33385628794_b912df519b_m.jpg', listing_id: "#{listing.id}")

    visit '/users/username/user'

    first('.listing').click_button 'Edit'
    expect(current_path).to eq "/listings/#{listing.id}/edit"

    fill_in :name, with: 'Jed House'
    fill_in :description, with: 'A lovely house in the village of Whatever'
    fill_in :price, with: '450.00'
    fill_in :url, with: "https://live.staticflickr.com/5482/30494278595_081c80f8cc_m.jpg"
    click_button 'Update'

    expect(current_path).to eq '/users/username/user'
    expect(page).not_to have_content 'Village House'
    expect(page).not_to have_content 'Lovely cottage in the countryside'
    expect(page).to have_content 'Jed House'
    expect(page).to have_content 'A lovely house in the village of Whatever'
    expect(page).to have_content '450.00'
    expect(page).to have_css "img[src='https://live.staticflickr.com/5482/30494278595_081c80f8cc_m.jpg']"
  end

  scenario 'a user can delete his own listings' do
    user_sign_in
    listing = Listing.create(name: 'Village House', description: 'Lovely cottage in the countryside', price: '50.00')
    Picture.create(url: 'https://live.staticflickr.com/5482/30494278595_081c80f8cc_m.jpg', listing_id: "#{listing.id}")

    visit '/users/username/user'

    first('.listing').click_button 'Delete'


    expect(current_path).to eq '/users/username/user'
    expect(page).not_to have_content 'Village House'
    expect(page).not_to have_content 'Lovely cottage in the countryside'
    expect(page).not_to have_content '50.00'
    expect(page).not_to have_css "img[src='https://live.staticflickr.com/5482/30494278595_081c80f8cc_m.jpg']"
  end
end
