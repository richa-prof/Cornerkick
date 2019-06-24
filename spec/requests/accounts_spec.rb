require 'rails_helper'

RSpec.describe 'accounts', type: :request do
  context 'anonymous' do
    let(:account) {Fabricate(:account)}

    describe 'GET /accounts/:id' do
      it 'requires authentication' do
        get account_path(account)
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'GET /accounts/:id/dashboard' do
      it 'requires authentication' do
        get dashboard_account_path(account)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  context 'user is site admin' do
    let(:user) {Fabricate(:user, site_admin: true)}
    let(:account) {Fabricate(:account)}

    before(:each) do
      login_as user
    end

    describe 'GET dashboard_accounts_path' do
      it 'returns successful response' do
        get dashboard_account_path(account)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET accounts_path' do
      it 'returns successful response' do
        get account_path(account)
        expect(response).to have_http_status(:success)
      end
    end
  end
end
