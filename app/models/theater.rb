class Theater < ApplicationRecord
	validates :theater_name, format: { with: /\A[a-zA-Z0-9A-z\d\s]+\Z/i}, presence: true, length: {maximum: 100}
	validates :address, presence: true, length: {maximum: 200}

	has_many :screenings
end