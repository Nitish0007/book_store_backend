class AddRef < ActiveRecord::Migration[6.1]
  def change
    add_reference :carts, :user, foreign_key: true
    add_reference :users, :cart, foreign_key: true
    add_reference :books, :order, foreign_key: true
    add_reference :orders, :user, foreign_key: true
  end
end
