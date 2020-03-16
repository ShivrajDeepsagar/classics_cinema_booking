class Seat < ApplicationRecord
	validates_presence_of :user_id
	validates_presence_of :reservation_id
	validates_presence_of :screening_id
	validates_presence_of :seat_details
	belongs_to :reservation
	belongs_to :screening
end
