class User < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :bookings_as_owner, through: :services, source: :bookings
  has_one_attached :photo

  validates :name, presence: true
  validates :email, uniqueness: true, presence: true
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  acts_as_favoritor
end
