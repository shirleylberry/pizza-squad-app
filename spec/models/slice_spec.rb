# == Schema Information
#
# Table name: slices
#
#  id         :integer          not null, primary key
#  pizza_id   :integer
#  order_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require_relative "../spec_helper.rb"

RSpec.describe Slice, type: :model do
  let(:user) {User.create(name: "Lucille Ball", email: "lucille@ilovelucy.com", password: "riiiicky")}
  let(:pres_user) {User.create(name: "Ricky Ricard", email: "ricky@ilovelucy.com", password: "LUUUCY")}
  let(:president) {President.create(user: pres_user)}
  let(:event) {Event.create(date: "2014-09-19 07:03:30 -0700", deadline: "2014-09-19 05:03:30 -0700", title: "PIZZA NOW", description: "YOU HEARD ME", president: president)}
  let(:order) {Order.create(user: user, event: event)}
  let(:pizza) {Pizza.create(topping: "pepperoni", price: 15.0)}

  let!(:slice) {Slice.create(order: order, pizza: pizza)}

  let(:no_pizza_attributes) {{order: order}}
  let(:no_order_attributes) {{pizza: pizza}}

  describe 'belongs_to associations' do
    it 'belongs to a pizza' do
      slice.pizza = pizza
      expect(slice.pizza).to eq(pizza)
    end

    it 'belongs to an order' do
      slice.order = order
      expect(slice.order).to eq(order)
    end
  end

  describe 'validations' do
    it 'is invalid without a pizza' do
      new_slice = Slice.new(no_pizza_attributes)
      expect(new_slice.save).to eq(false)
    end

    it 'is invalid without an order' do
      new_slice = Slice.new(no_order_attributes)
      expect(new_slice.save).to eq(false)
    end
  end
end

