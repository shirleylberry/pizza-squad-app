require 'rails_helper'
require 'capybara/rspec'

describe "the sign-up & login forms", :type => :feature do
  it 'allows the user to sign up' do
    visit '/users/sign_up'
    fill_in :user_name, with: 'Sally Bishop'
    fill_in :user_email, with: 'sally@bishop.com'
    fill_in :user_password, with: '12345678'
    fill_in :user_password_confirmation, with: '12345678'
    find('input[name="commit"]').click
    expect(page).to have_content("You have signed up successfully.")
  end

  it 'allows the user to sign in' do
    user = FactoryGirl.create(:user)

    visit '/users/sign_in'
    fill_in :user_email, with: 'sally@bishop.com'
    fill_in :user_password, with: '12345678'
    find('input[name="commit"]').click
    expect(page).to have_content("Signed in successfully.")
  end
end
