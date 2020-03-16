class Movie < ApplicationRecord
	validates :movie_name, presence: true
	validates :duration, numericality: true, presence: true

	has_many :screenings
end