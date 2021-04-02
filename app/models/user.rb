class User < ApplicationRecord
  belongs_to :terminal, optional: true

  validates_presence_of :username, :email, :password_digest
  validates :username, uniqueness: true

  enum role: { agent: 1, official: 2, admin: 3, super_admin: 4 }

  # encrypt password
  has_secure_password

  scope :active, -> { where(active: true) }
end
