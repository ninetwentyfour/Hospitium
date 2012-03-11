FactoryGirl.define do
  factory :animal do
    sequence(:name) { |n| "test_name_#{n}"}
    date_of_intake "2011-10-20 00:50:22"
    association :organization
    association :species
    association :animal_color
    association :biter
    association :spay_neuter
    association :status
    association :animal_sex
  end
  
  factory :organization do
    sequence(:name) { |n| "test_name_#{n}"}
  end
  
  factory :species do
    sequence(:name) { |n| "test_name_#{n}"}
    association :organization
  end
  
  factory :animal_color do
    sequence(:color) { |n| "test_name_#{n}"}
    association :organization
  end
  
  factory :animal_weight do
    weight 100
    date_of_weight "2011-10-20 00:50:22"
    association :organization
    association :animal
  end
  
  factory :status do
    sequence(:status) { |n| "test_name_#{n}"}
    association :organization
  end
  
  factory :biter do
    value "No"
  end
  
  factory :spay_neuter do
    spay "No"
  end
  
  factory :animal_sex do
    sex "male"
  end
  
  factory :adoption_contact do
    sequence(:first_name) { |n| "test_name_#{n}"}
    last_name "last name"
    address "511 Broadway Denver CO 80203"
    phone "5555555555"
    email "example@example.com"
    association :organization
  end


end