require 'rails_helper'

RSpec.describe ContactPolicy do
  let(:account) {Fabricate(:account)}
  let(:contact) {Fabricate(:contact, account: account)}

  subject {described_class}

  context 'user is site admin' do
    let(:user) {Fabricate(:user, site_admin: true)}

    permissions :show? do
      it 'allows access to any user' do
        expect(subject).to permit(user, contact)
      end
    end

    permissions :create? do
      it 'allows contact create' do
        expect(subject).to permit(user, contact)
      end
    end

    permissions :destroy? do
      it 'denies destroy for any user' do
        expect(subject).not_to permit(user, contact)
      end
    end
  end

  context 'user is account admin' do
    let(:account_admin_role) {Fabricate(:role, name: Role::ACCOUNT_ADMIN)}
    let(:user) do
      user = Fabricate(:user, site_admin: false)
      Fabricate(:role_assignment, user: user, role: account_admin_role, account: account)
      user
    end

    permissions :create? do
      it 'allows contact create' do
        expect(subject).to permit(user, contact)
      end
    end

    permissions :show? do
      it 'allows access to any user' do
        expect(subject).to permit(user, contact)
      end
    end
  end

  context 'user is team member' do
    let(:team_member_role) {Fabricate(:role, name: Role::TEAM_MEMBER)}
    let(:user) do
      user = Fabricate(:user, site_admin: false)
      Fabricate(:role_assignment, user: user, role: team_member_role, account: account)
      user
    end

    permissions :create? do
      it 'allows contact create' do
        expect(subject).to permit(user, contact)
      end
    end

    permissions :update? do
      it 'allows contact update' do
        expect(subject).to permit(user, contact)
      end
    end

    permissions :show? do
      it 'allows access to any user' do
        expect(subject).to permit(user, contact)
      end
    end
  end
end
