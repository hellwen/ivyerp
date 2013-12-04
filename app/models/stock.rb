class Stock < ActiveRecord::Base
  attr_accessible :bill_no, :handle_date, :handle_person, :handover_person, :remark, :spare_no, :status, :stock_type, :opt_type, :workshop_id, :stock_products_attributes
  #validates_presence_of :bill_no, :handle_date, :handle_person, :status, :stock_type, :type, :workshop_id

  has_many :stock_products, :autosave => true, :inverse_of => :stock, :dependent => :destroy
  accepts_nested_attributes_for :stock_products, :allow_destroy => true

  def attr_list                                                                     
    [:bill_no, :handle_date, :spare_no, :status]
  end

  # Operation type enumeration
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

  def self.available_products
    #Product.all.map { |r| [r.name, r.id, { class: r.code }] }
    Product.all.map { |r| [r.customer.name + ' ' + r.name + ' ' + r.specification, r.id] }
  end

  def self.available_locations
    StockLocation.all.map { |r| [r.building + '.' + r.floor.to_s + r.name, r.id] }
  end

  def to_s
    bill_no.present? ? bill_no : ''
  end
end
