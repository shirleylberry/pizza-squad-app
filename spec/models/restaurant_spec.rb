require_relative "../spec_helper.rb"



RSpec.describe Restaurant, type: :model do
  DatabaseCleaner.clean
  let!(:user) {User.create(name: "Jeff Winger", email: "jeff@coollawyer.com", password: "pierceisweird")}
  let!(:pres_user) {User.create(name: "Britta Perry", email: "britta@activism.com", password: "savethewhales")}
  let!(:president) {President.create(user: pres_user)}
  let(:restaurant) {Restaurant.create(name: "Joe's Pizza")}
  let!(:event) {Event.create(date: "2016-09-19 07:03:30 -0700", deadline: "2016-09-19 05:03:30 -0700", title: "FSP Pizza Party", description: "yum pizza yum", president: president)}
  let!(:pizza) {Pizza.create(price: "3", topping: "taco", restaurant: restaurant)}
  let!(:pizza1) {Pizza.create(price: "4", topping: "mushroom", restaurant: restaurant)}
  let!(:pizza2) {Pizza.create(price: "5", topping: "chicken", restaurant: restaurant)}


  describe 'belongs_to associations' do
    it 'restaurant belongs to a an event' do
      event.restaurant = restaurant
      expect(event.restaurant).to eq(restaurant)
    end
  end
end
