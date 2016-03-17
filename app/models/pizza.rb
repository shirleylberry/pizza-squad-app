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

class Pizza < ActiveRecord::Base
  has_many :slices

  validates :topping, presence: true
  validates :price, presence: true
end
