require 'rails_helper'

RSpec.describe RolePolicy do
  let(:user) {Fabricate(:user)}
  let(:role) {Fabricate(:role, name: Role::ACCOUNT_ADMIN)}

  subject {described_class}

  permissions :destroy? do
    it 'denies destroy for any user' do
      expect(subject).not_to permit(user, role)
    end
  end
end
