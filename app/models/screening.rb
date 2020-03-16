class Screening < ApplicationRecord
  validates :movie_id, presence: true
  validates :theater_id, numericality: true, presence: true, uniqueness: { scope: :ondate }
  validates :cost, numericality: true, presence: true
  validates_presence_of :ondate
  validates_presence_of :movie_id
  validates_presence_of :theater_id

  scope :ondate, ->{where(ondate: DateTime.now.to_date)}
  belongs_to :movie
  belongs_to :theater
  has_many :seats

  validate :atleast_one_show
  def atleast_one_show
  	if !(first || second || third || fourth)
  		self.errors.add(:first, :blank, message: "at-least one show should be selected")
  	end
  end
end