FactoryBot.define do
  factory :coordinator do
    sequence(:email) { |n| "coordinator#{n}@example.com" }
    name { "John Doe" }
    phone_number { "1234567890" }
  end
end
