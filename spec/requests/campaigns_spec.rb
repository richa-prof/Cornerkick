require 'rails_helper'

RSpec.describe 'campaigns', type: :request do
  let(:account) {Fabricate(:account)}
  let(:campaign) {Fabricate(:campaign, account: account)}

  context 'anonymous' do
    describe 'GET account_campaigns_path' do
      it 'requires authentication' do
        get account_campaigns_path(account)
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'GET account_campaign_path' do
      it 'requires authentication' do
        get account_campaign_path(account, campaign)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  context 'user is site admin' do
    let(:user) {Fabricate(:user, site_admin: true)}

    before(:each) do
      login_as user
    end

    describe 'GET account_campaigns_path' do
      it 'returns HTTP success' do
        get account_campaigns_path(account)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET account_campaign_path' do
      it 'returns HTTP success' do
        get account_campaign_path(account, campaign)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'POST account_campaigns_path' do
      context 'missing required attributes' do
        it 'raises ParameterMissing' do
          expect do
            post account_campaigns_path(account, {})
          end.to raise_error ActionController::ParameterMissing
        end
      end

      context 'with all valid attributes' do
        it 'creates a campaign and redirects' do
          expect do
            post account_campaigns_path(account), params: {campaign: {name: 'campaign'}}
          end.to change(Campaign.where(account: account), :count)

          campaign = Campaign.order(created_at: :desc).first
          expect(campaign.name).to eq 'campaign'
          expect(response).to redirect_to account_campaign_path(account, campaign)
        end
      end
    end

    describe 'PATCH account_campaign_path' do
      context 'missing required attributes' do
        it 'raises ParameterMissing' do
          expect do
            patch account_campaign_path(account, campaign), params: {}
          end.to raise_error ActionController::ParameterMissing
        end
      end

      context 'with all valid attributes' do
        it 'updates a campaign and redirects' do
          patch account_campaign_path(account, campaign), params: {campaign: {name: 'campaign'}}

          expect(response).to redirect_to account_campaign_path(account, campaign)
          campaign.reload
          expect(campaign.name).to eq 'campaign'
        end
      end
    end

    describe 'DELETE account_campaign_path' do
      it 'deletes specified campaign' do
        delete account_campaign_path(account, campaign)

        expect(Campaign.exists?(campaign.id)).to eq false
        expect(response).to redirect_to account_campaigns_path(account)
      end
    end

    describe 'POST generate_urls_account_campaign_path' do
      context 'with one target/source/ad' do
        before do
          Fabricate(:campaign_target, campaign: campaign)
          Fabricate(:campaign_source, campaign: campaign)
          Fabricate(:campaign_ad, campaign: campaign)
        end

        it 'generates a single url' do
          expect do
            post generate_urls_account_campaign_path(account, campaign), params: {}
          end.to change(CampaignUrl, :count)

          expect(response).to redirect_to account_campaign_path(account, campaign)
          campaign.reload
          expect(campaign.campaign_urls.count).to eq(1)
        end
      end
    end
  end
end
