class StockLocation < ActiveRecord::Base
  attr_accessible :active, :building, :floor, :name, :remark, :stock_type
  validates_presence_of :active, :building, :floor, :name, :stock_type

  def to_s
    name.present? ? name : ''
  end
end
