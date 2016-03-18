class AddPriceColumnToSlice < ActiveRecord::Migration
  def change
    add_column :slices, :price, :float, default: true
  end
end
