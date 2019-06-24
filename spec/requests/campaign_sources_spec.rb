require 'rails_helper'

RSpec.describe 'campaign_sources', type: :request do
  let(:account) {Fabricate(:account)}
  let(:campaign) {Fabricate(:campaign, account: account)}
  let(:campaign_source) {Fabricate(:campaign_source, campaign: campaign)}

  context 'anonymous' do
    describe 'GET account_campaign_campaign_sources_path' do
      it 'requires authentication' do
        get account_campaign_campaign_sources_path(account, campaign)
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'GET account_campaign_campaign_source_path' do
      it 'requires authentication' do
        get account_campaign_campaign_source_path(account, campaign, campaign_source)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  context 'user is site admin' do
    let(:user) {Fabricate(:user, site_admin: true)}

    before(:each) do
      login_as user
    end

    describe 'GET account_campaign_campaign_sources_path' do
      it 'returns HTTP success' do
        get account_campaign_campaign_sources_path(account, campaign)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET account_campaign_campaign_source_path' do
      it 'returns HTTP success' do
        get account_campaign_campaign_source_path(account, campaign, campaign_source)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'POST account_campaign_campaign_sources_path' do
      context 'missing required attributes' do
        it 'raises ParameterMissing' do
          expect do
            post account_campaign_campaign_sources_path(account, campaign, {})
          end.to raise_error ActionController::ParameterMissing
        end
      end

      context 'with all valid attributes' do
        it 'creates a campaign_source and redirects' do
          expect do
            post account_campaign_campaign_sources_path(account, campaign), params: {campaign_source: {name: 'campaign_source'}}
          end.to change(CampaignSource.where(campaign: campaign), :count)

          campaign_source = CampaignSource.order(created_at: :desc).first
          expect(campaign_source.name).to eq 'campaign_source'
          expect(response).to redirect_to account_campaign_path(account, campaign)
        end
      end
    end

    describe 'PATCH account_campaign_path' do
      context 'missing required attributes' do
        it 'raises ParameterMissing' do
          expect do
            patch account_campaign_campaign_source_path(account, campaign, campaign_source), params: {}
          end.to raise_error ActionController::ParameterMissing
        end
      end

      context 'with all valid attributes' do
        it 'updates a campaign_source and redirects' do
          patch account_campaign_campaign_source_path(account, campaign, campaign_source), params: {campaign_source: {name: 'campaign_source'}}

          expect(response).to redirect_to account_campaign_path(account, campaign)
          campaign_source.reload
          expect(campaign_source.name).to eq 'campaign_source'
        end
      end
    end

    describe 'DELETE account_campaign_path' do
      it 'deletes specified campaign' do
        delete account_campaign_campaign_source_path(account, campaign, campaign_source)

        expect(CampaignSource.exists?(campaign_source.id)).to eq false
        expect(response).to redirect_to account_campaign_path(account, campaign)
      end
    end
  end
end
