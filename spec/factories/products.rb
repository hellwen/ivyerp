# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    code "MyString"
    name "MyString"
    customer_id 1
    specification "MyString"
    remark "MyString"
    active 1
  end
end
