FactoryGirl.define do
  factory :animal do
    sequence(:name) { |n| "test_name_#{n}" }
    date_of_intake  '2011-10-20 00:50:22'
    association :organization, email: 'test@example.com'
    association :species
    association :animal_color
    association :biter
    association :spay_neuter
    association :status
    association :animal_sex
  end
end
