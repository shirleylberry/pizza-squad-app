class AddRestaurantToPizza < ActiveRecord::Migration
  def change
    add_column :pizzas, :restaurant_id, :integer
  end
end
