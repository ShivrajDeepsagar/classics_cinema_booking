class Coupon < ApplicationRecord
  validates_presence_of :code
  validates_presence_of :discount
end