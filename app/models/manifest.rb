class Manifest < ApplicationRecord
  # include SoftDeletable
  belongs_to :motor
  belongs_to :terminal, optional: true
  belongs_to :company,  optional: true
  has_many :manifest_people, dependent: :destroy
  has_many :people, through: :manifest_people
  belongs_to :destination_terminal, class_name: 'Terminal', foreign_key: 'destination_terminal_id', optional: true
  belongs_to :source_terminal, class_name: 'Terminal', foreign_key: 'source_terminal_id', optional: true
  # validates_presence_of :source_state, :destination_state, :source_terminal_id, :destination_terminal_id

  accepts_nested_attributes_for :manifest_people, allow_destroy: true
end
