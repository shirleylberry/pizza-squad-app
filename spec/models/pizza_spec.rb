# == Schema Information
#
# Table name: pizzas
#
#  id         :integer          not null, primary key
#  price      :decimal(, )
#  topping    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "rspec"
require_relative "../lib/pizzasquad"

RSpec.describe Pizza, type: :model do
  pizza = Pizza.create(price: "3", topping: "taco")

  describe 'attributes' do

    it 'has a price' do
      expect(pizza.price).to eq("3")
    end

    it 'has an topping' do
      expect(pizza.topping)to eq("taco")
    end

end

