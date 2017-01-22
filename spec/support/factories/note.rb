FactoryGirl.define do
  factory :note do
    note        'example'
    association :user
    association :animal
  end
end
