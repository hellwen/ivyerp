# encoding: utf-8
require "comm"

class StockIn < Stock
  default_scope where(:opt_type => 1)

  validates_presence_of :handle_date, :handle_person, :workshop_id

  before_create :update_default_column
  def update_default_column
    if bill_no.blank?
      self.bill_no = build_bill_no(StockIn, 'SI', 4)
    end

    self.opt_type = STOCKIN
    self.stock_type = STOCK_TYPE_PRODUCT
  end
end
