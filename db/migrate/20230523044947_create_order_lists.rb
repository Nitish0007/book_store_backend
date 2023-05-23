class CreateOrderLists < ActiveRecord::Migration[6.1]
  def change
    drop_table :books_orders
    add_column :orders, :price, :integer
    add_column :orders, :book_name, :string
    remove_reference :order_lists, :user, foreign_key: true
  end
end
