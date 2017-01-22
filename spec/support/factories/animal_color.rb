FactoryGirl.define do
  factory :animal_color do
    sequence(:color) { |n| "test_name_#{n}" }
    association :organization
  end
end
