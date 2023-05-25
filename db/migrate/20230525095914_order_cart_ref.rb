class OrderCartRef < ActiveRecord::Migration[6.1]
  def change
    remove_reference :carts, :order, foreign_key: true
    add_reference :orders, :cart, foreign_key: true
  end
end
