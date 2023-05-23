class RemoveRefOrders < ActiveRecord::Migration[6.1]
  def change
    remove_reference :orders, :users
  end
end
