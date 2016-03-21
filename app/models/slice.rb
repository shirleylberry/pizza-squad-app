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

class Slice < ActiveRecord::Base
  belongs_to :pizza
  has_one :restaurant, through: :pizza
  belongs_to :order

  validates :pizza_id, presence: true

  #### ANALYTICS ####

  def self.total_slices_by_type
    Pizza.pizzas_by_popularity.pluck("pizzas.topping, COUNT(slices.id)")
  end

  # for each order, how many of that slice are usually ordered, if that slice
  # type is in the order
  def self.average_ordered_per_order
    self.joins(:pizza).group("pizzas.topping").count
  end

  # def self.slices_consumed_by_type
  #   Slice.group(:pizza_id).count
  # end
end
