FactoryBot.define do
  factory :enrollment do
    association :coordinator
    association :registry
    association :participant
    date_of_enrollment { Date.today }
    method_of_contact { "Email" }
    remarks { "Some remarks" }
  end
end
