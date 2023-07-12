FactoryBot.define do
  factory :registry do
    sequence(:name) { |n| "Registry #{n}" }
    location { "Sample Location" }
    state { "Open" }
  end
end
