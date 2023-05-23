class AddOrderList < ActiveRecord::Migration[6.1]
  def change
    create_table :books_orders do |t|
      t.belongs_to :order
      t.belongs_to :book
    end
  end
end
