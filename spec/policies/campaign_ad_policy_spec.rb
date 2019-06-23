require 'rails_helper'

RSpec.describe CampaignAdPolicy do
  let(:account) {Fabricate(:account)}
  let(:campaign) {Fabricate(:campaign, account: account)}
  let(:campaign_ad) {Fabricate(:campaign_ad, campaign: campaign)}
  let(:account_admin_role) {Fabricate(:role, name: Role::ACCOUNT_ADMIN)}

  subject {described_class}

  context 'user is site admin' do
    let(:user) {Fabricate(:user, site_admin: true)}

    permissions :show? do
      it 'allows access to any user' do
        expect(subject).to permit(user, campaign_ad)
      end
    end

    permissions :create? do
      it 'allows campaign_ad create' do
        expect(subject).to permit(user, campaign_ad)
      end
    end

    permissions :destroy? do
      it 'allows campaign_ad destroy' do
        expect(subject).to permit(user, campaign_ad)
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
      it 'allows campaign_ad create' do
        expect(subject).to permit(user, campaign_ad)
      end
    end

    permissions :show? do
      it 'allows access to any user' do
        expect(subject).to permit(user, campaign_ad)
      end
    end

    permissions :destroy? do
      it 'allows campaign_ad destroy' do
        expect(subject).to permit(user, campaign_ad)
      end
    end
  end
end
