class Person < ApplicationRecord
  include SoftDeletable
  enum sex: { male: 1, female: 2 }
  enum person_type: { passenger: 1, driver: 2, assistant_driver: 3, conductor: 4 }
  # TODO: delete manifest on destroy
  has_many :manifest_people
end
