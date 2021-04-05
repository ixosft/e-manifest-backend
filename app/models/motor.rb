class Motor < ApplicationRecord
  validates_presence_of :brand, :number_plate
  validates :number_plate, uniqueness: true

  enum brand: BRANDS
  enum year: YEARS
  belongs_to :onwer, class_name: :Person, foreign_key: :person_id, optional: true
end
