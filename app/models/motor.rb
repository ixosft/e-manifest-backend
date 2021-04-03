class Motor < ApplicationRecord
  validates_presence_of :brand, :number_plate, :password_digest
  validates :number_plate, uniqueness: true

  enum brand: BRANDS
  enum year: YEARS
end
