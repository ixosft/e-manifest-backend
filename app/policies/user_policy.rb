class UserPolicy < ApplicationPolicy
  def create?
    user.permission_for_action?(CREATE, USER_ABILITIES)
  end

  def register?
    user.permission_for_action?(CREATE, USER_ABILITIES)
  end
end
