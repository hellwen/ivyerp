# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stock_product do
    stock_id 1
    product_id 1
    stock_location_id 1
    quantity 1
  end
end
