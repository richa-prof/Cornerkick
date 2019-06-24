require 'rails_helper'

RSpec.describe 'campaign_urls', type: :request do
  let(:account) {Fabricate(:account)}
  let(:campaign) {Fabricate(:campaign, account: account)}
  let(:campaign_url) {Fabricate(:campaign_url, campaign: campaign)}

  context 'anonymous' do
    describe 'GET account_campaign_campaign_url_path' do
      it 'requires authentication' do
        get account_campaign_campaign_url_path(account, campaign, campaign_url)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  context 'user is site admin' do
    let(:user) {Fabricate(:user, site_admin: true)}

    before(:each) do
      login_as user
    end

    describe 'GET account_campaign_campaign_url_path' do
      it 'returns HTTP success' do
        get account_campaign_campaign_url_path(account, campaign, campaign_url)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'PATCH account_campaign_campaign_url_path' do
      context 'missing required attributes' do
        it 'raises ParameterMissing' do
          expect do
            patch account_campaign_campaign_url_path(account, campaign, campaign_url), params: {}
          end.to raise_error ActionController::ParameterMissing
        end
      end

      context 'with all valid attributes' do
        it 'updates a campaign_url and redirects' do
          patch account_campaign_campaign_url_path(account, campaign, campaign_url), params: {campaign_url: {url: 'url'}}

          expect(response).to redirect_to account_campaign_path(account, campaign)
          campaign_url.reload
          expect(campaign_url.url).to eq 'url'
        end
      end
    end

    describe 'DELETE account_campaign_path' do
      it 'deletes specified campaign' do
        delete account_campaign_campaign_url_path(account, campaign, campaign_url)

        expect(CampaignUrl.exists?(campaign_url.id)).to eq false
        expect(response).to redirect_to account_campaign_path(account, campaign)
      end
    end
  end
end
