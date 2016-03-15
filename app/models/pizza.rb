class Pizza < ActiveRecord::Base
  has_many :slices

  validates :topping, presence: true
  validates :price, presence: true
end
