require 'rails_helper'

RSpec.describe 'tracker admin', type: :request do
  context 'anonymous' do
    describe 'GET /admin/tracker' do
      it 'requires authentication' do
        get admin_trackers_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  context 'user is site admin' do
    let(:user) {Fabricate(:user, site_admin: true)}
    let(:account) {Fabricate(:account)}
    let(:tracker) {Fabricate(:tracker, account: account)}

    before(:each) do
      login_as user
    end

    describe 'GET admin_trackers_path' do
      it 'returns successful response' do
        get admin_trackers_path
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET admin_tracker_path' do
      it 'returns successful response' do
        get admin_tracker_path(tracker)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET new_admin_tracker_path' do
      it 'returns successful response' do
        get new_admin_tracker_path
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET edit_admin_tracker_path' do
      it 'returns successful response' do
        get edit_admin_tracker_path(tracker)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'POST admin_trackers_path' do
      context 'missing required attributes' do
        it 'raises ParameterMissing' do
          expect do
            post admin_trackers_path, params: {}
          end.to raise_error ActionController::ParameterMissing
        end
      end

      context 'without account' do
        it 'renders error message' do
          post admin_trackers_path, params: {tracker: {account_id: ''}}
          expect(response.body).to include 'li>Account must exist</li>'
        end
      end

      context 'with all valid attributes' do
        it 'creates an contact and redirects' do
          expect do
            post admin_trackers_path, params: {tracker: {identifier: 'CK-ABC', account_id: account.id}}
          end.to change(Tracker, :count)

          tracker = Tracker.order(created_at: :desc).first
          expect(response).to redirect_to admin_tracker_path(tracker)
        end
      end
    end

    describe 'PATCH admin_tracker_path' do
      context 'missing required attributes' do
        it 'raises ParameterMissing' do
          expect do
            patch admin_tracker_path(tracker), params: {}
          end.to raise_error ActionController::ParameterMissing
        end
      end

      context 'with invalid name' do
        it 'renders error message' do
          patch admin_tracker_path(tracker), params: {tracker: {account_id: ''}}
          expect(response.body).to include 'li>Account must exist</li>'
        end
      end

      context 'with all valid attributes' do
        it 'updates a tracker and redirects' do
          patch admin_tracker_path(tracker), params: {tracker: {identifier: 'CK-123'}}

          tracker.reload
          expect(tracker.identifier).to eq 'CK-123'
          expect(response).to redirect_to admin_tracker_path(tracker)
        end
      end
    end
  end
end
