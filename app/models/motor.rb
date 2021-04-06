class Motor < ApplicationRecord
  include SoftDeletable
  validates_presence_of :brand, :number_plate
  validates :number_plate, uniqueness: true

  enum brand: BRANDS
  enum year: YEARS
  has_many :manifests
  belongs_to :onwer, class_name: :Person, foreign_key: :person_id, optional: true
end
