FactoryGirl.define do
  factory :animal_weight do
    weight 100
    date_of_weight '2011-10-20 00:50:22'
    association :organization
    association :animal
  end
end
