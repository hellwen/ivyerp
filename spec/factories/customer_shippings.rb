# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer_shipping do
    customer_id 1
    name "MyString"
    address "MyString"
  end
end
