require 'rails_helper'

RSpec.describe TrackerPolicy do
  let(:account) {Fabricate(:account)}
  let(:tracker) {Fabricate(:tracker, account: account)}
  let(:account_admin_role) {Fabricate(:role, name: Role::ACCOUNT_ADMIN)}

  subject {described_class}

  context 'user is site admin' do
    let(:user) {Fabricate(:user, site_admin: true)}

    permissions :show? do
      it 'allows access to any user' do
        expect(subject).to permit(user, tracker)
      end
    end

    permissions :create? do
      it 'allows tracker create' do
        expect(subject).to permit(user, tracker)
      end
    end

    permissions :destroy? do
      it 'allows tracker destroy' do
        expect(subject).to permit(user, tracker)
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
      it 'allows tracker create' do
        expect(subject).to permit(user, tracker)
      end
    end

    permissions :show? do
      it 'allows access to any user' do
        expect(subject).to permit(user, tracker)
      end
    end

    permissions :destroy? do
      it 'allows tracker destroy' do
        expect(subject).to permit(user, tracker)
      end
    end
  end
end
