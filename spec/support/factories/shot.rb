FactoryGirl.define do
  factory :shot do
    name 'test'
    last_administered '2011-10-20 00:50:22'
    expires '2011-10-20 00:50:22'
    association :organization
    association :animal
  end
end
