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

# had to remove .limit(3) because total_slices_by_type chart relies on this query method
  def self.pizzas_by_popularity
    Pizza.joins(:slices).group(:topping).order("COUNT(slices.id) DESC")
  end
end
