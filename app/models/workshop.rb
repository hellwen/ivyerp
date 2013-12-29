class Workshop < ActiveRecord::Base
  attr_accessible :name, :descript

  def to_s
    name.present? ? name : ''
  end
end
