class Restaurant < ActiveRecord::Base
  has_many :pizzas
  has_many :events
  has_many :slices, through: :pizzas


end
