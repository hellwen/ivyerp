# encoding: utf-8
require "comm"

class StockOut < Stock
  default_scope where(:opt_type => 2)

  def attr_list
    [:bill_no, :handle_date, :spare_no]
  end

  before_save :update_default_column
  def update_default_column
    if bill_no.blank?
      self.bill_no = build_bill_no(StockOut, 'SO', 4)
    end

    self.opt_type = STOCKOUT
    self.stock_type = STOCK_TYPE_PRODUCT
  end
end
