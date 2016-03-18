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
  belongs_to :order

  validates :pizza_id, presence: true

  def self.get_num_slices_per_order(order)
    toppings_hash = Pizza.all.each_with_object({}) do |pizza, pizza_toppings_hash|
      count_of_topping = Slice.joins(:pizza, :order).where("slices.pizza_id = ? AND slices.order_id = ?", pizza.id, order.id).count
      pizza_toppings_hash[pizza.topping] = count_of_topping unless count_of_topping == 0
    end
  end

  # def self.get_slices_per_order(order)
  #   toppings_hash = Pizza.all.each_with_object({}) do |pizza, pizza_toppings_hash|
  #     count_of_topping = Slice.joins(:pizza, :order).where("slices.pizza_id = ? AND slices.order_id = ?", pizza.id, order.id)
  #     pizza_toppings_hash[pizza.topping] = count_of_topping unless count_of_topping == 0
  #   end
  #   byebug
  # end

  #### ANALYTICS ####

  def self.total_slices_by_type
    Pizza.pizzas_by_popularity.pluck("pizzas.topping, COUNT(slices.id)")
  end

end
