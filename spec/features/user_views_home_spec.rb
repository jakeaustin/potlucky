require 'rails_helper'

feature 'User views home page' do
  scenario ' creates a new meal' do
    sign_in_as(create(:user))

    click_link 'New meal'
    fill_in 'Title', with: 'A new meal'
    fill_in 'Location', with: 'my house'
    click_button 'Create Meal!'

    expect(page).to have_content 'A new meal'
  end
end
