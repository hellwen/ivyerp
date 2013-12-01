class StockProduct < ActiveRecord::Base
  attr_accessible :product_id, :quantity, :stock_id, :stock_location_id
end
