class JtiKey < ActiveRecord::Migration[6.1]
  def change
    remove_reference :jtis, :user
    drop_table :jtis
    add_column :users, :jti_key, :string
  end
end
