FactoryGirl.define do
  factory :adopt_animal do
    association :animal
    association :adoption_contact
  end
end