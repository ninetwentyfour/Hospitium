FactoryGirl.define do
  factory :permission do
    user { |a| a.association(:user) }
    role { |a| a.association(:role) }
  end
end
