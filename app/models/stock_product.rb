class StockProduct < ActiveRecord::Base
  attr_accessible :product_id, :quantity, :stock_id, :stock_location_id, :position

  belongs_to :stock, :touch => true, :inverse_of => :stock_products
  belongs_to :product
  belongs_to :stock_location

  validate :stock, :presence => true

  def to_s
    product.name
  end
end