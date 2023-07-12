class Registry < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :participants, through: :enrollments, dependent: :destroy
  has_and_belongs_to_many :coordinators, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :location, presence: true
  validates :state, inclusion: { in: %w[Open Closed], message: 'must be either "Open" or "Closed"' }
end
