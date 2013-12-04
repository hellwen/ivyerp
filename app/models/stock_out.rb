class StockOut < Stock
  default_scope where(:opt_type => 2)

  before_save :update_default_column
  def update_default_column
    self.status = 'N'
    self.opt_type = STOCKOUT
  end
end
