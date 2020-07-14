feature 'Signing Out' do
  scenario 'a user can sign out' do
    User.create(username: 'username', email: 'email@email.com', password: 'test_password')

    visit '/sessions/new'

    fill_in :username, with: 'username'
    fill_in :password, with: 'test_password'
    click_button 'Sign In'

    expect(current_path).to eq '/'

    click_button 'Sign Out'

    expect(current_path).to eq '/'
    expect(page).to have_content 'You have signed out!'
  end
end
