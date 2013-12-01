class Product < ActiveRecord::Base
  attr_accessible :active, :code, :customer_id, :name, :remark, :specification
  validates_presence_of :code, :name, :active, :customer_id

  belongs_to :customer

  def to_s
    name.present? ? name : ''
  end
end
