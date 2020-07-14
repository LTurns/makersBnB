def sign_up
  visit('/signup')
  expect(page).to have_content "Sign Up"
  fill_in('username', with: 'user1')
  fill_in('email', with: 'email@email.com')
  fill_in('password', with: 'password123')
  click_button('Register')
end
