class CreateJtis < ActiveRecord::Migration[6.1]
  def change
    create_table :jtis do |t|
      t.timestamps
    end
  end
end
