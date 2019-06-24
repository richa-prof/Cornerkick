require 'rails_helper'

RSpec.describe 'groups', type: :request do
  let(:account) {Fabricate(:account)}
  let(:group) {Fabricate(:group, account: account)}

  context 'anonymous' do
    describe 'GET account_groups_path' do
      it 'requires authentication' do
        get account_groups_path(account)
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'GET account_group_path' do
      it 'requires authentication' do
        get account_group_path(account, group)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  context 'user is site admin' do
    let(:user) {Fabricate(:user, site_admin: true)}

    before(:each) do
      login_as user
    end

    describe 'GET account_groups_path' do
      it 'returns HTTP success' do
        get account_groups_path(account)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET account_group_path' do
      it 'returns HTTP success' do
        get account_group_path(account, group)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'POST account_groups_path' do
      context 'missing required attributes' do
        it 'raises ParameterMissing' do
          expect do
            post account_groups_path(account, {})
          end.to raise_error ActionController::ParameterMissing
        end
      end

      context 'with all valid attributes' do
        it 'creates a group and redirects' do
          expect do
            post account_groups_path(account), params: {group: {name: 'Group', description: 'Description'}}
          end.to change(Group.where(account: account), :count)

          group = Group.order(created_at: :desc).first
          expect(group.name).to eq 'Group'
          expect(response).to redirect_to account_group_path(account, group)
        end
      end
    end

    describe 'PATCH account_group_path' do
      context 'missing required attributes' do
        it 'raises ParameterMissing' do
          expect do
            patch account_group_path(account, group), params: {}
          end.to raise_error ActionController::ParameterMissing
        end
      end

      context 'with all valid attributes' do
        it 'updates a group and redirects' do
          patch account_group_path(account, group), params: {group: {name: 'Group', description: 'Description'}}

          expect(response).to redirect_to account_group_path(account, group)
          group.reload
          expect(group.name).to eq 'Group'
        end
      end
    end

    describe 'DELETE account_group_path' do
      it 'deletes specified group' do
        delete account_group_path(account, group)

        expect(Group.exists?(group.id)).to eq false
        expect(response).to redirect_to account_groups_path(account)
      end
    end
  end
end
