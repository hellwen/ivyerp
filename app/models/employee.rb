class Employee < ActiveRecord::Base
  attr_accessible :sex, :code, :name, :email, :phone, :mobile, :office_location, :job_id, :department_id, :id_card, :home_addr, :date_of_birth, :date_of_leaved, :remark

  def attr_list
    [:code, :name]
  end

  belongs_to :job
  belongs_to :department
  
  # sex enumeration
  MALE   = 1
  FEMALE = 2
  def sex_to_s(format = :default)
    case sex
    when MALE
      "M"
    when FEMALE
      "F"
    end
  end

  def to_s
    name.present? ? name : ""
  end
end
