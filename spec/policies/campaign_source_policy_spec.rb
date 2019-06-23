require 'rails_helper'

RSpec.describe CampaignSourcePolicy do
  let(:account) {Fabricate(:account)}
  let(:campaign) {Fabricate(:campaign, account: account)}
  let(:campaign_source) {Fabricate(:campaign_source, campaign: campaign)}
  let(:account_admin_role) {Fabricate(:role, name: Role::ACCOUNT_ADMIN)}

  subject {described_class}

  context 'user is site admin' do
    let(:user) {Fabricate(:user, site_admin: true)}

    permissions :show? do
      it 'allows access to any user' do
        expect(subject).to permit(user, campaign_source)
      end
    end

    permissions :create? do
      it 'allows campaign_source create' do
        expect(subject).to permit(user, campaign_source)
      end
    end

    permissions :destroy? do
      it 'allows campaign_source destroy' do
        expect(subject).to permit(user, campaign_source)
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
      it 'allows campaign_source create' do
        expect(subject).to permit(user, campaign_source)
      end
    end

    permissions :show? do
      it 'allows access to any user' do
        expect(subject).to permit(user, campaign_source)
      end
    end

    permissions :destroy? do
      it 'allows campaign_source destroy' do
        expect(subject).to permit(user, campaign_source)
      end
    end
  end
end
