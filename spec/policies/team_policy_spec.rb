require 'rails_helper'

RSpec.describe TeamPolicy do
  let(:user) {Fabricate(:user)}
  let(:team) {Fabricate(:team)}

  subject {described_class}

  permissions :destroy? do
    it 'denies destroy for any user' do
      expect(subject).not_to permit(user, team)
    end
  end
end
