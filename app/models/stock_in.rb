# encoding: utf-8
class StockIn < Stock
  default_scope where(:opt_type => 1)


  before_save :update_default_column
  def update_default_column
    self.status = 'C'
    self.opt_type = STOCKIN
    self.stock_type = STOCK_TYPE_PRODUCT
  end
end
