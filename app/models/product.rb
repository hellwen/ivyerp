# encoding: utf-8
class Product < ActiveRecord::Base
  attr_accessible :code, :customer_id, :name, :remark, :specification
  validates_presence_of :code, :name, :customer_id

  #scope :by_name, -> name { where("name like :name", :name => '%' + name + '%') }
  #User.where(users[:name].matches("%#{user_name}%"))

  def attr_list
    [:code, :name, :customer, :specification]
  end

  belongs_to :customer
  has_many :stock_products, :dependent => :nullify

  #scope :by_name, joins(:stock_products),  -> name { where("products.name like :name", :name => "%" + name + "%") }

  def self.by_text(text)
    joins(:customer).where("products.name like ? or customers.name like ?", "%" + text + "%", "%" + text + "%")
  end

  def to_s
    name.present? ? name : ''
  end
end
