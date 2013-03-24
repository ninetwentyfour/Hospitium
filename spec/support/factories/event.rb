FactoryGirl.define do
  factory :event do
    event_type    "test"
    event_message "test message"
    association   :animal
  end
end