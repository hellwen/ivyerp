# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :department do
    dept_name "MyString"
    descript "MyString"
    active false
  end
end
