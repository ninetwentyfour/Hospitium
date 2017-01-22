FactoryGirl.define do
  factory :species do
    sequence(:name) { |n| "test_name_#{n}" }
    association :organization
  end
end
