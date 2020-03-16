class Payment

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :card_number, :card_name, :exp_month, :exp_year, :cvv

  validates :card_number, format: { with: /\A[0-9]{12}\Z/i}, presence: true
  validates :card_name, presence: true, format: { with: /\A[a-zA-Z0-9A-z\d\s]+\Z/i}
  validates :exp_month, presence: true, numericality: {greater_than: 0, less_than_or_equal_to: 12}
  validates :exp_year, presence: true, numericality: {greater_than_or_equal_to: 17, less_than_or_equal_to: 99}
  validates :cvv, presence: true, format: { with: /\A[0-9]{3}\Z/i}

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end