require 'rails_helper'
require 'capybara/rspec'

describe "the event form", :type => :feature do
  before :each do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)

    visit '/events/new'
    fill_in :event_title, with: 'Pizza Party'
    fill_in :event_date, with: '3/20/2016 6pm'
    fill_in :event_deadline, with: '3/20/2016 5pm'
    find('input[name="commit"]').click
  end

  it "sets the title" do
    expect(page).to have_content("Pizza Party")
  end

  it "sets the date" do
    expect(page).to have_content("March 20, 2016 at 6:00 pm")
  end

  it "sets the deadline" do
    expect(page).to have_content("March 20, 2016 at 5:00 pm")
  end
end
