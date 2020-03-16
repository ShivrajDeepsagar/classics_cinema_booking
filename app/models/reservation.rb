class Reservation < ApplicationRecord
  validates_presence_of :screening_id
  validates_presence_of :user_id
  belongs_to :screening
  belongs_to :user
  has_one :seat
end