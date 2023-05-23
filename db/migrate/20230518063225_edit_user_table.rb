class EditUserTable < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_admin, :string
  end
end
