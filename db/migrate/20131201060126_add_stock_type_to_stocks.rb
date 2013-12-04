class AddStockTypeToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :stock_type, :integer
  end
end
