FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "test title #{n}" }
    content 'test content'
  end
end
