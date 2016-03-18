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

  #### ANALYTICS ####

  def self.pizzas_by_popularity
    Pizza.joins(:slices).group(:topping).order("COUNT(slices.id) DESC")
  end
end
