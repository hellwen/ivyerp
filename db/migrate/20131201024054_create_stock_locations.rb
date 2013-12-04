class CreateStockLocations < ActiveRecord::Migration
  def change
    create_table :stock_locations do |t|
      t.integer :type, :null => false
      t.string :building, :null => false
      t.integer :floor, :null => false
      t.string :name, :null => false
      t.string :remark
      t.integer :active

      t.timestamps
    end

    add_index :stock_locations, [:type, :building, :floor, :name], :unique => true
  end
end
