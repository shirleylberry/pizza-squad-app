class CreateSlices < ActiveRecord::Migration
  def change
    create_table :slices do |t|
      t.integer :pizza_id
      t.integer :order_id

      t.timestamps null: false
    end
  end
end
