FactoryGirl.define do
  factory :organization do
    sequence(:name) { |n| "test_name_#{n}" }
  end
end
