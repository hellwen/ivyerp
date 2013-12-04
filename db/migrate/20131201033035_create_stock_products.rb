class CreateStockProducts < ActiveRecord::Migration
  def change
    create_table :stock_products do |t|
      t.integer :stock_id, :null => false
      t.integer :product_id, :null => false
      t.integer :stock_location_id, :null => false
      t.integer :quantity, :null => false

      t.timestamps
    end
  end
end
