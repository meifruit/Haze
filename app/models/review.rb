class Review < ApplicationRecord
  belongs_to :user
  belongs_to :service

  validates :comment, presence: true
  validates :comment, length: { minimum: 10 }
  validates :rating, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 }
end
