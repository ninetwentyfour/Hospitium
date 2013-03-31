FactoryGirl.define do
  factory :relinquish_animal do
    association :animal
    association :relinquishment_contact
  end
end