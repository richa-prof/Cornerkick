require 'rails_helper'

RSpec.describe 'group admin', type: :request do
  context 'anonymous' do
    describe 'GET /admin/groups' do
      it 'requires authentication' do
        get admin_groups_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  context 'user is site admin' do
    let(:user) {Fabricate(:user, site_admin: true)}
    let(:account) {Fabricate(:account)}
    let(:group) {Fabricate(:group, account: account)}

    before(:each) do
      login_as user
    end

    describe 'GET admin_groups_path' do
      it 'returns successful response' do
        get admin_groups_path
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET admin_group_path' do
      it 'returns successful response' do
        get admin_group_path(group)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET new_admin_group_path' do
      it 'returns successful response' do
        get new_admin_group_path
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET edit_admin_group_path' do
      it 'returns successful response' do
        get edit_admin_group_path(group)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'POST admin_groups_path' do
      context 'missing required attributes' do
        it 'raises ParameterMissing' do
          expect do
            post admin_groups_path, params: {}
          end.to raise_error ActionController::ParameterMissing
        end
      end

      context 'without account' do
        it 'renders error message' do
          post admin_groups_path, params: {group: {account_id: ''}}
          expect(response.body).to include 'li>Account must exist</li>'
        end
      end

      context 'with all valid attributes' do
        it 'creates an contact and redirects' do
          expect do
            post admin_groups_path, params: {group: {name: 'New Group', account_id: account.id}}
          end.to change(Group, :count)

          group = Group.order(created_at: :desc).first
          expect(response).to redirect_to admin_group_path(group)
        end
      end
    end

    describe 'PATCH admin_group_path' do
      context 'missing required attributes' do
        it 'raises ParameterMissing' do
          expect do
            patch admin_group_path(group), params: {}
          end.to raise_error ActionController::ParameterMissing
        end
      end

      context 'with invalid name' do
        it 'renders error message' do
          patch admin_group_path(group), params: {group: {account_id: ''}}
          expect(response.body).to include 'li>Account must exist</li>'
        end
      end

      context 'with all valid attributes' do
        it 'updates a group and redirects' do
          patch admin_group_path(group), params: {group: {name: 'Updated'}}

          group.reload
          expect(group.name).to eq 'Updated'
          expect(response).to redirect_to admin_group_path(group)
        end
      end
    end
  end
end
