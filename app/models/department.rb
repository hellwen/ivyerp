class Department < ActiveRecord::Base
  attr_accessible :name, :descript, :active

  def to_s
    name.present? ? name : ""
  end
end
