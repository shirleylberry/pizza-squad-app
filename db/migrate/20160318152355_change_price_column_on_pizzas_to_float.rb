class ChangePriceColumnOnPizzasToFloat < ActiveRecord::Migration
  def change
    change_column :pizzas, :price, :float
  end
end
