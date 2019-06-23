class AccountPolicy < ApplicationPolicy
  def index?
    false
  end

  def show?
    RoleAssignment.where(user: user, account: record).exists? || user.site_admin?
  end

  def create?
    user.site_admin?
  end

  def new?
    create?
  end

  def update?
    user.site_admin?
  end

  def edit?
    update?
  end

  def destroy?
    user.site_admin?
  end

  def dashboard?
    RoleAssignment.where(user: user, account: record).exists? || user.site_admin?
  end

  class Scope < Scope
    def resolve
      if user.site_admin?
        scope.all
      else
        # account_admin = Cornerkick::Role.find_by(name: 'Account Admin')
        # scope
        #   .joins(:role_assignments)
        #   .where('cornerkick_role_assignments.role_id = :role and cornerkick_role_assignments.user_id = :user',
        #          role: account_admin, user: user)
        # account_admin = Cornerkick::Role.find_by(name: 'Account Admin')
        scope
            .joins(:role_assignments)
            .where('cornerkick_role_assignments.user_id = :user', user: user)
      end
    end
  end
end
