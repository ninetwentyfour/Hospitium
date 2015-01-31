FactoryGirl.define do
  factory :user do
    sequence(:username)          { |n| "test_name_#{n}"}
    sequence(:email)             { |n| "user_#{n}@example.com"}
    sequence(:organization_name) { |n| "test_name_#{n}#{n}"}
    password                     "password"
    password_confirmation        "password"
    association                  :organization
    owner                        1
    confirmed_at                 "2011-10-05 10:34:01"
    reset_password_token nil
  end
end