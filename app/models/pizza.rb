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

class Pizza < ActiveRecord::Base
  has_many :slices
  belongs_to :restaurant

  validates :topping, presence: true
  validates :price, presence: true

  #### ANALYTICS ####

  def self.pizzas_by_popularity
    Pizza.joins(:slices).group('pizzas.topping').order("COUNT(slices.id) DESC").limit(3)
  end
end
