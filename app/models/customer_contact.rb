# encoding: utf-8
class CustomerContact < ActiveRecord::Base
  attr_accessible :customer_id, :name, :phone, :title, :position

  belongs_to :customer, :touch => true, :inverse_of => :customer_contacts

  validate :customer, :presence => true

  def to_s
    name.present? ? name : ''
  end
end
