class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :service
  validates :start_date, presence: true
  validates :end_date, presence: true
  enum :status, [:unbooked, :pending, :rejected, :accepted, :completed]
end
