class EditPasswordField < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :encrypted_password
    add_column :users, :password_digest, :string
  end
end
