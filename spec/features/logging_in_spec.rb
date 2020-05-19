feature 'Log In' do
  scenario 'a user can log in into his account' do
    User.create(username: 'username', email: 'email@email.com', password: 'test_password')

    visit '/sessions/new'

    expect(page).to have_content "Sign In"
    fill_in :username, with: 'username'
    fill_in :password, with: 'test_password'
    click_button 'Sign In'

    expect(current_path).to eq '/'
    # expect(page).to have_content "Welcome test_user!"
  end
end