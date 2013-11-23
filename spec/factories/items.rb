# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    item_type "MyString"
    item_id 1
    item_order 1
    item_name "MyString"
    active false
  end
end
