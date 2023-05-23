class AddNewRef < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :order_list, foreign_key: true
    add_reference :carts, :order, foreign_key: true
  end
end
