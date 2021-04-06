class Manifest < ApplicationRecord
  include SoftDeletable
  belongs_to :motor
  belongs_to :terminal
  belongs_to :company
  has_many :manifest_people, dependent: :destroy
  has_many :people, through: :manifest_people

  validates_presence_of :source_state, :destination_state

  accepts_nested_attributes_for :manifest_people, allow_destroy: true
end
