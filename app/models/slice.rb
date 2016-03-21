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

  # def self.get_num_slices_per_order(order)
  #   Slice.joins(:order, :pizza).where("orders.id = ?", order).group("pizzas.topping").count
    # toppings_hash = Pizza.all.each_with_object({}) do |pizza, pizza_toppings_hash|
    #   count_of_topping = Slice.joins(:pizza, :order).where("slices.pizza_id = ? AND slices.order_id = ?", pizza.id, order.id).count
    #   pizza_toppings_hash[pizza.topping] = count_of_topping unless count_of_topping == 0
    # end
  # end
  # ^^^^^^^^^ DUPLICATE OF order.slices_by_type ^^^^^^^^^ #

  # def self.get_slices_per_order(order)
  #   toppings_hash = Pizza.all.each_with_object({}) do |pizza, pizza_toppings_hash|
  #     count_of_topping = Slice.joins(:pizza, :order).where("slices.pizza_id = ? AND slices.order_id = ?", pizza.id, order.id)
  #     pizza_toppings_hash[pizza.topping] = count_of_topping unless count_of_topping == 0
  #   end
  # end

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
