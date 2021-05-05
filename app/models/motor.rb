class Motor < ApplicationRecord
  include SoftDeletable
  validates_presence_of :brand, :number_plate
  validates :number_plate, uniqueness: true

  enum brand: BRANDS
  has_many :manifests
  belongs_to :onwer, class_name: :Person, foreign_key: :person_id, optional: true

  def validate_motor_type
    # TODO
  end
end
