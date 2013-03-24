FactoryGirl.define do
  factory :adoption_contact do
    sequence(:first_name) { |n| "test_name_#{n}"}
    last_name             "last name"
    address               "511 Broadway Denver CO 80203"
    phone                 "5555555555"
    email                 "example@example.com"
    association           :organization
  end
end