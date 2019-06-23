class GroupPolicy < ApplicationPolicy
  def create?
    user.site_admin? || user.account_admin?(record.account)
  end

  def destroy?
    user.site_admin? || user.account_admin?(record.account)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
