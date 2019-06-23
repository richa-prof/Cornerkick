  class ContactPolicy < ApplicationPolicy
    def create?
      RoleAssignment.where(user: user, account: record.account).exists? || user.site_admin?
    end

    def update?
      RoleAssignment.where(user: user, account: record.account).exists? || user.site_admin?
    end

    class Scope < Scope
      def resolve
        scope
      end
    end
  end
