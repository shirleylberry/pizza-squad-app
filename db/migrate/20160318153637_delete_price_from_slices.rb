class DeletePriceFromSlices < ActiveRecord::Migration
  def change
    remove_column :slices, :price, :float
  end
end
