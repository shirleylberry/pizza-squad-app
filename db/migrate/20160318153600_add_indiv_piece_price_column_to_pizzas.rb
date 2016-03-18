class AddIndivPiecePriceColumnToPizzas < ActiveRecord::Migration
  def change
    add_column :pizzas, :indiv_piece_price, :float, default: true
  end
end
