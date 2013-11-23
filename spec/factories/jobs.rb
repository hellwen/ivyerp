# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job do
    job_name 1
    descript "MyString"
    active false
  end
end
