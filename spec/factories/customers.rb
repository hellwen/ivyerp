# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer do
    code "MyString"
    name "MyString"
    remark "MyString"
    active false
  end
end
