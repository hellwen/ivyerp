# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stock do
    bill_no "MyString"
    spare_no "MyString"
    handle_date "2013-12-01"
    type 1
    workshop_id 1
    handover_person "MyString"
    handle_person "MyString"
    status 1
    remark "MyString"
  end
end
