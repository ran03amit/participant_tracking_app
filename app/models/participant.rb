class Participant < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :registries, through: :enrollments, dependent: :destroy

  validates :name, presence: true
  validates :gender, presence: true
  validates :date_of_birth, presence: true
  validates_uniqueness_of :name, scope: [:gender, :date_of_birth]
end