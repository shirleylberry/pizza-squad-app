class SetEmailColToDeviseDefaultsForUsers < ActiveRecord::Migration
  def change
    ## Database authenticatable
    change_column :users, :email, :string, null: false, default: ""
  end
end
