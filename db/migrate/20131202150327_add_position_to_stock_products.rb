class AddPositionToStockProducts < ActiveRecord::Migration
  def change
    add_column :stock_products, :position, :integer
  end
end
