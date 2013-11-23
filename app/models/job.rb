class Job < ActiveRecord::Base
  attr_accessible :active, :descript, :name

  def to_s
    name.present? ? name : '' 
  end
end
