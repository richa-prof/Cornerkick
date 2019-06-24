require 'rails_helper'

RSpec.describe 'user admin', type: :request do
  context 'anonymous' do
    describe 'GET /admin/users' do
      it 'requires authentication' do
        get admin_users_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  context 'user is site admin' do
    let(:user) {Fabricate(:user, site_admin: true)}
    let(:account) {Fabricate(:account)}
    let(:record) {Fabricate(:user)}

    before(:each) do
      login_as user
    end

    describe 'GET admin_users_path' do
      it 'returns successful response' do
        get admin_users_path
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET admin_user_path' do
      it 'returns successful response' do
        get admin_user_path(record)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET new_admin_user_path' do
      it 'returns successful response' do
        get new_admin_user_path
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET edit_admin_user_path' do
      it 'returns successful response' do
        get edit_admin_user_path(record)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'POST admin_users_path' do
      context 'missing required attributes' do
        it 'raises ParameterMissing' do
          expect do
            post admin_users_path, params: {}
          end.to raise_error ActionController::ParameterMissing
        end
      end

      context 'without account' do
        it 'renders error message' do
          post admin_users_path, params: {user: {email: ''}}
          expect(response.body).to include 'li>Email can&#39;t be blank</li>'
        end
      end

      context 'with all valid attributes' do
        it 'creates an contact and redirects' do
          expect do
            post admin_users_path, params: {user: {email: 'new@example.com', password: 'password'}}
          end.to change User, :count

          record = User.order(created_at: :desc).first
          expect(response).to redirect_to admin_user_path(record)
        end
      end
    end

    describe 'PATCH admin_user_path' do
      context 'missing required attributes' do
        it 'raises ParameterMissing' do
          expect do
            patch admin_user_path(record), params: {}
          end.to raise_error ActionController::ParameterMissing
        end
      end

      context 'with invalid name' do
        it 'renders error message' do
          patch admin_user_path(record), params: {user: {email: ''}}
          expect(response.body).to include 'li>Email can&#39;t be blank</li>'
        end
      end

      context 'with all valid attributes' do
        it 'updates a user and redirects' do
          patch admin_user_path(record), params: {user: {email: 'updated@example.com'}}

          record.reload
          expect(record.email).to eq 'updated@example.com'
          expect(response).to redirect_to admin_user_path(record)
        end
      end
    end
  end
end
