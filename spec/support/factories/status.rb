FactoryGirl.define do
  factory :status do
    sequence(:status) { |n| "test_name_#{n}" }
    association :organization
  end
end
