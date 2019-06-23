require 'rails_helper'

RSpec.describe BrowserPolicy do
  let(:user) {Fabricate(:user)}
  let(:browser) {Fabricate(:browser)}

  subject {described_class}

  permissions :destroy? do
    it 'denies destroy for any user' do
      expect(subject).not_to permit(user, browser)
    end
  end
end
