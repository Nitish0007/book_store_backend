class ChangeReforderlist < ActiveRecord::Migration[6.1]
  def change
    remove_reference :users, :order_list, foreign_key: true
    add_reference :order_lists, :user, foreign_key: true
  end
end
