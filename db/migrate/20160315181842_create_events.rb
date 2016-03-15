class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :date
      t.string :title
      t.text :description
      t.datetime :deadline
      t.integer :president_id

      t.timestamps null: false
    end
  end
end
