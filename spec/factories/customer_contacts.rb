# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer_contact do
    customer_id 1
    title "MyString"
    name "MyString"
    phone "MyString"
  end
end
