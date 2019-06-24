require 'rails_helper'

RSpec.describe 'accounts admin', type: :request do
  context 'anonymous' do
    describe 'GET /admin/accounts' do
      it 'requires authentication' do
        get admin_accounts_path
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

    describe 'GET admin_accounts_path' do
      it 'returns successful response' do
        get admin_accounts_path
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET admin_account_path' do
      it 'returns successful response' do
        get admin_account_path(account)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET new_admin_account_path' do
      it 'returns successful response' do
        get new_admin_account_path
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET edit_admin_account_path' do
      it 'returns successful response' do
        get edit_admin_account_path(account)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'POST admin_accounts_path' do
      context 'missing required attributes' do
        it 'raises ParameterMissing' do
          expect do
            post admin_accounts_path, params: {}
          end.to raise_error ActionController::ParameterMissing
        end
      end

      context 'with invalid name' do
        it 'renders error message' do
          post admin_accounts_path, params: {account: {name: ''}}
          expect(response.body).to include 'li>Name can&#39;t be blank</li>'
        end
      end

      context 'with all valid attributes' do
        it 'creates an account and redirects' do
          expect do
            post admin_accounts_path, params: {account: {name: 'New Account'}}
          end.to change(Account, :count)

          account = Account.order(created_at: :desc).first
          expect(response).to redirect_to admin_account_path(account)
        end
      end
    end

    describe 'PATCH admin_account_path' do
      context 'missing required attributes' do
        it 'raises ParameterMissing' do
          expect do
            patch admin_account_path(account), params: {}
          end.to raise_error ActionController::ParameterMissing
        end
      end

      context 'with invalid name' do
        it 'renders error message' do
          patch admin_account_path(account), params: {account: {name: ''}}
          expect(response.body).to include 'li>Name can&#39;t be blank</li>'
        end
      end

      context 'with all valid attributes' do
        it 'updates an account and redirects' do
          patch admin_account_path(account), params: {account: {name: 'New Account'}}

          account.reload
          expect(account.name).to eq 'New Account'
          expect(response).to redirect_to admin_account_path(account)
        end
      end
    end

    #   describe 'DELETE admin_account_path' do
    #     context 'deleting valid account' do
    #       it 'deletes account and redirects' do
    #         expect do
    #           delete admin_account_path(account)
    #         end.to change Account, :count
    #         expect(response).to redirect_to admin_accounts_url
    #         expect(response.body).to include 'Account was successfully destroyed.'
    #       end
    #     end
    #
    #     # context 'deleting nonexistent account' do
    #     #
    #     # end
    #   end
  end
end
