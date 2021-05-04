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


saved_list = Product.objects.filter(saved_items__user_account=request.user)

https://docs.google.com/forms/d/e/1FAIpQLSfUCSyObKZDjjtAhIgc8r5FrA4VSUflq1dMK6QyYMv33LeEDQ/viewform?c=0&w=1&emailAddress=omedale@gmail.com&entry.838873576=Oluwafemi%20Medale&entry.1191000917=undefined&entry.1269347964=abdullah.rafique01@gmail.com&entry.1846957123=Abdullah%20Rafique&entry.478142644_sentinel=Interactive%20Front%20End%20Development&entry.775489883=00:00:00&entry.2010663110=Average%20-%20The%20student%20is%20moving%20at%20an%20acceptable%20pace.&entry.1882714143=&entry.401267824=&emailReceipt=true