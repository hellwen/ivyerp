class StockLocation < ActiveRecord::Base
  attr_accessible :active, :building, :floor, :name, :remark, :stock_type
  validates_presence_of :active, :building, :floor, :name, :stock_type

  has_many :stock_products

  def attr_list
    [:building, :floor, :name]
  end

  def to_s
    building.present? ? building.to_s : '' + floor.present? ? floor.to_s : '' + name.present? ? name : ''
  end
end
