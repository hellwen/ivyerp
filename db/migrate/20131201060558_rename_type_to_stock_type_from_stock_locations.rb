class RenameTypeToStockTypeFromStockLocations < ActiveRecord::Migration
  def up
    remove_index :stock_locations, :name => 'index_stock_locations_on_type_and_building_and_floor_and_name'
    rename_column :stock_locations, :type, :stock_type
    add_index :stock_locations, [:stock_type, :building, :floor, :name], :unique => true, :name => 'index_stock_location'
  end

  
  def down
  end
end
