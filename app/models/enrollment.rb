class Enrollment < ApplicationRecord
  belongs_to :registry
  belongs_to :coordinator
  belongs_to :participant

  validates :participant_id, uniqueness: { scope: :registry_id, message: "has already been enrolled in this registry" }
  validates :date_of_enrollment, presence: true
  validates :method_of_contact, presence: true
  validates :remarks, presence: true
  validates :coordinator_id, presence: true
end
