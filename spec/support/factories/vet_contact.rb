FactoryGirl.define do
  factory :vet_contact do
    sequence(:clinic_name) { |n| "test_name_#{n}"}
    address                "511 Broadway Denver CO 80203"
    phone                  "5555555555"
    email                  "example@example.com"
    association            :organization
  end
end