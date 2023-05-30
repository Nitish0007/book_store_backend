class RemoveRefs < ActiveRecord::Migration[6.1]
  def change
    remove_reference :orders, :order_list
    remove_reference :orders, :cart, foreign_key: true
    drop_table :order_lists
    drop_table :carts
  end
end
