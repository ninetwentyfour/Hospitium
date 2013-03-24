FactoryGirl.define do
  factory :shelter do
    sequence(:name) { |n| "test_name_#{n}"}
    contact_first   "first name"
    contact_last    "last name"
    address         "511 Broadway Denver CO 80203"
    phone           "5555555555"
    email           "example@example.com"
    website         "www.example.com"
    association     :organization
  end
end