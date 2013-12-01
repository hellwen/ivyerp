class Stock < ActiveRecord::Base
  attr_accessible :bill_no, :handle_date, :handle_person, :handover_person, :remark, :spare_no, :status, :stock_type, :type, :workshop_id
  validates_presence_of :bill_no, :handle_date, :handle_person, :status, :stock_type, :type, :workshop_id

  # type enumeration
  STOCKIN  = 1
  STOCKOUT = 2

  # stock type enumeration
  STOCK_TYPE_PRODUCT  = 1
  def stock_type_to_s(format = :defautl)
    case stock_type
    when STOCK_TYPE_PRODUCT 
      I18n::localize('product')
    end
  end

  def to_s
    bill_no.present? ? bill_no : ''
  end
end
