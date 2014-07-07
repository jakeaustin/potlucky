require 'rails_helper'

feature 'Visitor views homepage' do
  scenario 'and is not signed in' do
    visit root_path

    expect(page).to have_content 'potlucky let\'s you plan your meals'
    expect(page).to have_content 'Get Started!'

  end
end
