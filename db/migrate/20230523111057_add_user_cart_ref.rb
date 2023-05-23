class AddUserCartRef < ActiveRecord::Migration[6.1]
  def change
    remove_reference :users, :cart
    add_reference :carts, :user, foreign_key: true
  end
end
