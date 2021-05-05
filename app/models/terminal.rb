class Terminal < ApplicationRecord
  include SoftDeletable
  include Utility::Object
  has_many :users
  belongs_to :manager, class_name: :User, foreign_key: :manager_id, optional: true
  validates_presence_of :state, :terminal
  validate :validate_state_lgts

  has_many :manifests

  def validate_state_lgts
    unless validate_state_lgt(state, terminal)
      # TODO: separete state and terminal validation
      errors.add(:state, 'invalid state selection')
    end
  end
end
