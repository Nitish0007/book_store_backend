class AddJtiRef < ActiveRecord::Migration[6.1]
  def change
    add_reference :jtis, :user, foreign_key: true
    add_column :jtis, :key, :string
  end
end
