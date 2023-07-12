class Coordinator < ApplicationRecord
  has_many :enrollments
  has_many :participants, through: :enrollments
  has_and_belongs_to_many :registries

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "should be a valid email address" }
  validates :phone_number, presence: true, format: { with: /\A\d{10}\z/, message: "should be a 10-digit number" }
end
