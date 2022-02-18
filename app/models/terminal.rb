class Terminal < ApplicationRecord
  include SoftDeletable
  include Utility::Object
  include Searchable
  has_many :users
  belongs_to :manager, class_name: :User, foreign_key: :manager_id, optional: true
  validates_presence_of :state

  has_many :manifests
end
