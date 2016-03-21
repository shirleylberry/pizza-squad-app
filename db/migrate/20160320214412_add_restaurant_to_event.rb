class AddRestaurantToEvent < ActiveRecord::Migration
  def change
    add_column :events, :restaurant_id, :integer
  end
end
