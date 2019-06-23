require 'rails_helper'

RSpec.describe UserPolicy do
  let(:record) {Fabricate(:user)}

  subject {described_class}

  context 'user is site admin' do
    let(:user) {Fabricate(:user, site_admin: true)}

    permissions :show? do
      it 'allows access to any user' do
        expect(subject).to permit(user, record)
      end
      # pending "add some examples to (or delete) #{__FILE__}"
    end

    permissions :destroy? do
      it 'denies destroy for any user' do
        expect(subject).not_to permit(user, record)
      end
    end
  end

  context 'user is account admin' do
    let(:user) {Fabricate(:user, site_admin: false)}

    permissions :show? do
      # pending "add some examples to (or delete) #{__FILE__}"
    end
  end
end
