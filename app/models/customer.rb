# encoding: utf-8
class Customer < ActiveRecord::Base
  attr_accessible :code, :name, :remark, :customer_shippings_attributes, :customer_contacts_attributes

  has_many :customer_shippings, :autosave => true, :inverse_of => :customer, :dependent => :destroy
  accepts_nested_attributes_for :customer_shippings, :allow_destroy => true
  has_many :customer_contacts, :autosave => true, :inverse_of => :customer, :dependent => :destroy
  accepts_nested_attributes_for :customer_contacts, :allow_destroy => true

  has_many :products, :dependent => :nullify

  def attr_list
    [:code, :name]
  end

  # Code
  after_save :update_code
  def update_code
    # Only set calculated code if not set, yet
    return unless code.blank?

    code = created_at.strftime("%y%m")
    code += "%04i" % id

    update_column(:code, code)
  end

  # Copying
  #def copy
  #  dup
  #end

  def to_s
    name.present? ? name : ''
  end
end
