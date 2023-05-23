class ChangeColNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :cart_id, null: false
    change_column_null :orders, :user_id, null: false
    
  end
end
