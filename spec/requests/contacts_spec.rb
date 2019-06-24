require 'rails_helper'

RSpec.describe 'contacts', type: :request do
  let(:account) {Fabricate(:account)}
  let(:contact) {Fabricate(:contact, account: account)}
  let(:account_admin_role) {Fabricate(:role, name: Role::ACCOUNT_ADMIN)}

  context 'anonymous' do
    describe 'GET account_contacts_path' do
      it 'requires authentication' do
        get account_contacts_path(account)
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'GET account_contact_path' do
      it 'requires authentication' do
        get account_contact_path(account, contact)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  context 'user is site admin' do
    let(:site_admin) {Fabricate(:user, site_admin: true)}

    before(:each) do
      login_as site_admin
    end

    describe 'GET account_contacts_path' do
      it 'returns HTTP success' do
        get account_contacts_path(account)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET account_contact_path' do
      it 'returns HTTP success' do
        get account_contact_path(account, contact)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'POST account_contacts_path' do
      context 'missing required attributes' do
        it 'raises ParameterMissing' do
          expect do
            post account_contacts_path(account, {})
          end.to raise_error ActionController::ParameterMissing
        end
      end

      context 'with all valid attributes' do
        it 'creates an account and redirects' do
          expect do
            post account_contacts_path(account), params: {contact: {first_name: 'First', last_name: 'Last'}}
          end.to change(Contact.where(account: account), :count)

          contact = Contact.order(created_at: :desc).first
          expect(response).to redirect_to account_contact_path(account, contact)
        end
      end
    end
  end

  context 'user is account admin' do
    let(:account_admin) do
      user = Fabricate(:user, site_admin: false)
      Fabricate(:role_assignment, user: user, role: account_admin_role, account: account)
      user
    end

    before(:each) do
      login_as account_admin
    end

    context 'with all valid attributes' do
      it 'creates an account and redirects' do
        expect do
          post account_contacts_path(account), params: {contact: {first_name: 'First', last_name: 'Last'}}
        end.to change(Contact.where(account: account), :count)

        contact = Contact.order(created_at: :desc).first
        expect(response).to redirect_to account_contact_path(account, contact)
      end
    end
  end
end
