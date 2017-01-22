FactoryGirl.define do
  factory :wordpress_account do
    sequence(:blog_user) { |n| "test_name_#{n}" }
    blog_password        'password'
    site_url             'http://example.com'
    active               1
    association          :organization
    association          :user
  end
end
