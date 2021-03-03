class StrollSettingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  # def show?
  #   user_is_owner_or_admin?
  # end

  def edit?
    user_is_owner_or_admin?
  end

  def create?
    return true
  end

  def update?
    user_is_owner_or_admin?
  end

  # def destroy?
  #   user_is_owner_or_admin?
  # end

  private

  def user_is_owner_or_admin?
    user == record.user || user.admin == true
  end
end
