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

require "rspec"
require_relative "../lib/pizzasquad"

RSpec.describe Slice, type: :model do
  slice = Slice.create(pizza_id: "1", order_id: "1")

  describe 'belongs_to associations' do
    let(:slice) {Slice.new}
    let(:pizza) {Pizza.new}
    let(:order) {Order.new}

      it 'belongs to a pizza' do
        slice.pizza = pizza
        expect(slice.pizza).to eq(pizza)
      end

      it 'belongs to an order' do
        slice.order = order
        expect(slice.order).to eq(order)
      end

  describe 'attributes' do

    it 'has a pizza_id' do
      expect(slice.pizza_id).to eq("1")
    end

    it 'has an order_id' do
      expect(slice.pizza_id)to eq("1")
    end


end

