feature 'User sign up' do
  scenario 'A user can sign up' do
    visit('/')
    click_button('Sign Out')
    click_button('Sign Up')
    sign_up
  end

  scenario 'An email/username already exists' do
    User.create(
      email: 'email@email.com',
      password: 'password123',
      username: 'user1'
    )
    sign_up
    expect(page).to have_content "this username/email already exists"
  end
end
