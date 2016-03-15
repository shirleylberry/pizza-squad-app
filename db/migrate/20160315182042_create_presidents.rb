class CreatePresidents < ActiveRecord::Migration
  def change
    create_table :presidents do |t|
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
