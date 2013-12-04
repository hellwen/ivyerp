# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stock_location do
    type 1
    building "MyString"
    floor 1
    name "MyString"
    remark "MyString"
    active 1
  end
end
