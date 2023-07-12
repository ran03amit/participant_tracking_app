FactoryBot.define do
  factory :participant do
    sequence(:name) { |n| "Participant #{n}" }
    gender { "Male" }
    date_of_birth { Date.new(2000, 1, 1) }
  end
end
