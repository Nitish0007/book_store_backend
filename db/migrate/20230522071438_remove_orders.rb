class RemoveOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :books, :order_id, index: true
  end
end
