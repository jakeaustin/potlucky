require 'rails_helper'

feature 'Visitor views homepage' do
  scenario 'and is not signed in' do
    visit root_path

    expect(page).to have_content 'Plan meals, pick dishes, invite your friends!'
    expect(page).to have_button 'Get Started!'
  end
  scenario 'and creates an account successfully' do

    visit root_path
    click_button 'Get Started!'
    fill_in 'Email', with: 'test@tester.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    expect(page).to have_content (/signed up successfully/)
  end
  scenario 'and creates an account unsuccessfully' do
    visit root_path
    click_button 'Get Started!'
    click_button 'Sign up'

    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Password can't be blank"
  end
  scenario 'and logs in as a user' do
    user = create(:user)
    visit root_path
    click_link 'Login'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    expect(page).to have_content (/Signed in successfully/)
  end

  # maybe profile editing, too
end

