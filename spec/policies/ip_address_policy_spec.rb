require 'rails_helper'

RSpec.describe IpAddressPolicy do
  let(:user) {Fabricate(:user)}
  let(:ip_address) {Fabricate(:ip_address)}

  subject {described_class}

  permissions :destroy? do
    it 'denies destroy for any user' do
      expect(subject).not_to permit(user, ip_address)
    end
  end
end
