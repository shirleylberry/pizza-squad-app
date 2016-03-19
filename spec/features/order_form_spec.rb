require 'rails_helper'
require 'capybara/rspec'

describe "the ordering process", :type => :feature do
  before :each do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)

    event = FactoryGirl.create(:event)
    president = FactoryGirl.create(:president)
  end

  it "lets user add order from event page" do
    visit '/events/1'
    expect(page).to have_link("add_order")
  end

  it "asks user to input how many slices they want" do
    visit '/events/1'
    find('a[id="add_order"]').click
    expect(page).to have_field("num_slices")
  end

  it "renders the right number of slice topping selection fields" do
    visit '/events/1/orders/enter_slices'
    fill_in :num_slices, with: "2"
    find('input[name="commit"]').click
    expect(page).to have_css("select", count: 2)
  end

  it "creates correct order" do
    pizza1 = FactoryGirl.create(:cheese_pizza)
    pizza2 = FactoryGirl.create(:mushroom_pizza)

    visit '/events/1/orders/new?num_slices=2&commit=Get+some+za'
    page.select "Mushroom", from: "order_slices_attributes_1_pizza_id"
    find('input[name="commit"]').click
    expect(page).to have_content("You ordered: Cheese Mushroom")
  end
end
