class Transactions < ApplicationRecord
	validates_presence_of :seat_id
	validates_presence_of :reservation_id
	validates_presence_of :screening_id
end