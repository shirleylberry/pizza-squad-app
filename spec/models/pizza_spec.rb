# == Schema Information
#
# Table name: pizzas
#
#  id                :integer          not null, primary key
#  price             :float
#  topping           :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  indiv_piece_price :float            default("1.0")
#

require_relative "../spec_helper.rb"

RSpec.describe Pizza, type: :model do
  let!(:pizza) {Pizza.create(price: "3", topping: "taco")}
  let(:no_price_attributes){{topping: "all the cheese"}}
  let(:no_topping_attributes){{price: "17.0"}}

  describe 'attributes' do
    it 'has a price' do
      expect(pizza.price).to eq(3.0)
    end

    it 'has a topping' do
      expect(pizza.topping).to eq("taco")
    end
  end

  describe 'validations' do
    it 'is invalid without a price' do
      no_price_pizza = Pizza.new(no_price_attributes)
      expect(no_price_pizza.save).to eq(false)
    end

    it 'is invalid without a topping' do
      no_topping_pizza = Pizza.new(no_topping_attributes)
      expect(no_topping_pizza.save).to eq(false)
    end
  end
end

