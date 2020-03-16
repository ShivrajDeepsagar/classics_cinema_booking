class Buyticket

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :screening_id, :show, :tickets

  validates :screening_id, numericality: true, presence: true
  validates :show, numericality: true, presence: true
  validates :tickets, numericality: true, presence: true

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end