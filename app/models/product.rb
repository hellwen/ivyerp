class Product < ActiveRecord::Base
  attr_accessible :code, :customer_id, :name, :remark, :specification
  validates_presence_of :code, :name, :customer_id

  def attr_list
    [:code, :name, :customer, :specification]
  end

  belongs_to :customer
  has_many :stock_products, :dependent => :nullify

  def to_s
    name.present? ? name : ''
  end
end
