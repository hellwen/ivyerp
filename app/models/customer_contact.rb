class CustomerContact < ActiveRecord::Base
  attr_accessible :customer_id, :name, :phone, :title

  def to_s
    name.present? ? name : ''
  end
end
