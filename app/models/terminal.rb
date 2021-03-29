class Terminal < ApplicationRecord
  include Utility::Object
  has_many :users
  belongs_to :manager, class_name: :User, foreign_key: :manager_id, optional: true
  validate :validate_state_lgts

  def validate_state_lgts
    unless validate_state_lgt(state, local_goverment)
      # TODO: separete state and local_goverment validation
      errors.add(:state, 'invalid state selection')
    end
  end
end
