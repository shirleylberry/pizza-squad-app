class CreatePizzas < ActiveRecord::Migration
  def change
    create_table :pizzas do |t|
      t.decimal :price
      t.string :topping

      t.timestamps null: false
    end
  end
end
