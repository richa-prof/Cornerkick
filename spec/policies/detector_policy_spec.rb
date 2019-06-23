require 'rails_helper'

RSpec.describe DetectorPolicy do
  let(:account) {Fabricate(:account)}
  let(:detector) {Fabricate(:detector, account: account)}
  let(:account_admin_role) {Fabricate(:role, name: Role::ACCOUNT_ADMIN)}

  subject {described_class}

  context 'user is site admin' do
    let(:user) {Fabricate(:user, site_admin: true)}

    permissions :show? do
      it 'allows access to any user' do
        expect(subject).to permit(user, detector)
      end
    end

    permissions :create? do
      it 'allows detector create' do
        expect(subject).to permit(user, detector)
      end
    end

    permissions :destroy? do
      it 'allows detector destroy' do
        expect(subject).to permit(user, detector)
      end
    end
  end

  context 'user is account admin' do
    let(:user) do
      user = Fabricate(:user, site_admin: false)
      Fabricate(:role_assignment, user: user, role: account_admin_role, account: account)
      user
    end

    permissions :create? do
      it 'allows detector create' do
        expect(subject).to permit(user, detector)
      end
    end

    permissions :show? do
      it 'allows access to any user' do
        expect(subject).to permit(user, detector)
      end
    end

    permissions :destroy? do
      it 'allows detector destroy' do
        expect(subject).to permit(user, detector)
      end
    end
  end
end
