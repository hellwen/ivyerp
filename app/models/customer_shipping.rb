class CustomerShipping < ActiveRecord::Base
  attr_accessible :address, :customer_id, :name

  belongs_to :customer, :touch => true, :inverse_of => :customer_shippings

  validate :customer, :presence => true

  # Copying
  #def copy
  #  new_item = dup
  #  new_item
  #end

  def to_s
    name.present? ? name : ''
  end
end
