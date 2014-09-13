FactoryGirl.define do
  factory :foster_animal do
    association :animal
    association :foster_contact
  end
end