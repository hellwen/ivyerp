class ChangeActiveInStockLocations < ActiveRecord::Migration
  def up
    change_column :stock_locations, :active, :boolean, :default => true
  end

  def down
  end
end
