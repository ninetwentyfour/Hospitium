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
  
  factory :relinquishment_contact do
    sequence(:first_name) { |n| "test_name_#{n}"}
    last_name "last name"
    address "511 Broadway Denver CO 80203"
    phone "5555555555"
    email "example@example.com"
    association :organization
  end
  
  factory :shelter do
    sequence(:name) { |n| "test_name_#{n}"}
    contact_first "first name"
    contact_last "last name"
    address "511 Broadway Denver CO 80203"
    phone "5555555555"
    email "example@example.com"
    website "www.example.com"
    association :organization
  end
  
  factory :user do
    sequence(:username)               { |n| "test_name_#{n}"}
    sequence(:email)                  { |n| "user_#{n}@example.com"}
    sequence(:organization_name)                  { |n| "test_name_#{n}"}
    password               "password"
    password_confirmation  "password"
    association :organization
    owner 1
  end
  
  factory :vet_contact do
    sequence(:clinic_name) { |n| "test_name_#{n}"}
    address "511 Broadway Denver CO 80203"
    phone "5555555555"
    email "example@example.com"
    association :organization
  end
  
  factory :volunteer_contact do
    sequence(:first_name) { |n| "test_name_#{n}"}
    last_name "last name"
    address "511 Broadway Denver CO 80203"
    phone "5555555555"
    email "example@example.com"
    association :organization
  end
  
  factory :notification do
    message "test notification"
    status_type "Tip"
  end
  
  factory :role do
    name "Admin"
  end
  
  Factory.define :permission do |b|
    b.user {|a| a.association(:user)}
    b.role {|a| a.association(:role)}
  end



end