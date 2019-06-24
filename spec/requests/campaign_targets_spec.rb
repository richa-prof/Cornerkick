require 'rails_helper'

RSpec.describe 'campaign_targets', type: :request do
  let(:account) {Fabricate(:account)}
  let(:campaign) {Fabricate(:campaign, account: account)}
  let(:campaign_target) {Fabricate(:campaign_target, campaign: campaign)}

  context 'anonymous' do
    describe 'GET account_campaign_campaign_targets_path' do
      it 'requires authentication' do
        get account_campaign_campaign_targets_path(account, campaign)
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'GET account_campaign_campaign_target_path' do
      it 'requires authentication' do
        get account_campaign_campaign_target_path(account, campaign, campaign_target)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  context 'user is site admin' do
    let(:user) {Fabricate(:user, site_admin: true)}

    before(:each) do
      login_as user
    end

    describe 'GET account_campaign_campaign_targets_path' do
      it 'returns HTTP success' do
        get account_campaign_campaign_targets_path(account, campaign)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET account_campaign_campaign_target_path' do
      it 'returns HTTP success' do
        get account_campaign_campaign_target_path(account, campaign, campaign_target)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'POST account_campaign_campaign_targets_path' do
      context 'missing required attributes' do
        it 'raises ParameterMissing' do
          expect do
            post account_campaign_campaign_targets_path(account, campaign, {})
          end.to raise_error ActionController::ParameterMissing
        end
      end

      context 'with all valid attributes' do
        it 'creates a campaign_target and redirects' do
          expect do
            post account_campaign_campaign_targets_path(account, campaign), params: {campaign_target: {landing_page: 'landing-page'}}
          end.to change(CampaignTarget.where(campaign: campaign), :count)

          campaign_target = CampaignTarget.order(created_at: :desc).first
          expect(campaign_target.landing_page).to eq 'landing-page'
          expect(response).to redirect_to account_campaign_path(account, campaign)
        end
      end
    end

    describe 'PATCH account_campaign_path' do
      context 'missing required attributes' do
        it 'raises ParameterMissing' do
          expect do
            patch account_campaign_campaign_target_path(account, campaign, campaign_target), params: {}
          end.to raise_error ActionController::ParameterMissing
        end
      end

      context 'with all valid attributes' do
        it 'updates a campaign_target and redirects' do
          patch account_campaign_campaign_target_path(account, campaign, campaign_target), params: {campaign_target: {landing_page: 'landing_page'}}

          expect(response).to redirect_to account_campaign_path(account, campaign)
          campaign_target.reload
          expect(campaign_target.landing_page).to eq 'landing_page'
        end
      end
    end

    describe 'DELETE account_campaign_path' do
      it 'deletes specified campaign' do
        delete account_campaign_campaign_target_path(account, campaign, campaign_target)

        expect(CampaignTarget.exists?(campaign_target.id)).to eq false
        expect(response).to redirect_to account_campaign_path(account, campaign)
      end
    end
  end
end
