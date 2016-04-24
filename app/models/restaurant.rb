class Restaurant < ActiveRecord::Base
  has_many :pizzas
  has_many :events
  has_many :slices, through: :pizzas

  def restaurant_profit
    self.events.inject(0) {|memo, event| memo + event.total_price}
  end

  def self.restaurant_profit_total
    self.all.each_with_object({}) do |restaurant, hash|
      hash[restaurant.name] = restaurant.restaurant_profit
    end
  end
end
