class Manifest < ApplicationRecord
  belongs_to :motor
  belongs_to :terminal
  belongs_to :company
  has_many :manifest_people, dependent: :delete_all
  has_many :people, through: :manifest_people

  validates_uniqueness_of :source_state, :destination_state

  accepts_nested_attributes_for :manifest_people, allow_destroy: true
end
