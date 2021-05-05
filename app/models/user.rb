class User < ApplicationRecord
  include SoftDeletable
  belongs_to :terminal, optional: true

  validates_presence_of :username, :password_digest
  validates :username, uniqueness: true

  enum role: { agent: 1, official: 2, admin: 3, super_admin: 4 }

  # encrypt password
  has_secure_password

  scope :active, -> { where(active: true) }

  def permission_for_action?(action, abilities)
    permissions = abilities[role.to_sym]
    return true if permissions[:all]

    actions = permissions[:actions]
    actions.include?(action.to_sym)
  end

  def permission_graph
    ALL_ABILITIES.each_with_object({}) do |abilities, hash|
      permissions = abilities[role.to_sym]
      hash[abilities[:name]] = { all: permissions[:all], actions: permissions[:actions] || [] }
    end
  end
end
