class StarredLocationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def create?
    true
  end

  def index?
    true
  end

  def destroy?
    true
  end
end
