# encoding: utf-8
require "comm"

class Customer < ActiveRecord::Base
  attr_accessible :code, :name, :remark, :customer_shippings_attributes, :customer_contacts_attributes
  validates_presence_of :name

  has_many :customer_shippings, :autosave => true, :inverse_of => :customer, :dependent => :destroy
  accepts_nested_attributes_for :customer_shippings, :allow_destroy => true
  has_many :customer_contacts, :autosave => true, :inverse_of => :customer, :dependent => :destroy
  accepts_nested_attributes_for :customer_contacts, :allow_destroy => true

  has_many :products, :dependent => :nullify

  def attr_list
    [:code, :name]
  end

  before_create :b_create
  def b_create
    return unless code.blank?

    self.code = build_code(Customer, 'C', 4)
  end

  # Copying
  #def copy
  #  dup
  #end

  def to_s
    name.present? ? name : ''
  end
end
