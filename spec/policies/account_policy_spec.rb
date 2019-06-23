require 'rails_helper'

RSpec.describe AccountPolicy do
  subject {described_class}

  let(:unlinked_account) {Fabricate(:account)}

  context 'user is site admin' do
    let(:user) {Fabricate(:user, site_admin: true)}

    permissions :show? do
      it 'allows access to any account' do
        expect(subject).to permit(user, unlinked_account)
      end
    end

    permissions :create? do
      it 'allows account creation' do
        expect(subject).to permit(user, unlinked_account)
      end
    end
    permissions :destroy? do
      it 'allows account destroy' do
        expect(subject).to permit(user, unlinked_account)
      end
    end
  end

  context 'user is account admin' do
    let(:user) {Fabricate(:user, site_admin: false)}

    permissions :show? do
      it 'forbids access to an unlinked account' do
        expect(subject).not_to permit(user, unlinked_account)
      end
    end

    permissions :create? do
      it 'forbids account creation' do
        expect(subject).not_to permit(user, unlinked_account)
      end
    end

    permissions :destroy? do
      it 'forbids account destroy' do
        expect(subject).not_to permit(user, unlinked_account)
      end
    end
  end
end
