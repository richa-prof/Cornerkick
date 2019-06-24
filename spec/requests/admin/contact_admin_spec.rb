require 'rails_helper'

RSpec.describe 'contact admin', type: :request do
  context 'anonymous' do
    describe 'GET /admin/contacts' do
      it 'requires authentication' do
        get admin_contacts_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  context 'user is site admin' do
    let(:user) {Fabricate(:user, site_admin: true)}
    let(:account) {Fabricate(:account)}
    let(:contact) {Fabricate(:contact, account: account)}

    before(:each) do
      login_as user
    end

    describe 'GET admin_contacts_path' do
      it 'returns successful response' do
        get admin_contacts_path
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET admin_contact_path' do
      it 'returns successful response' do
        get admin_contact_path(contact)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET new_admin_contact_path' do
      it 'returns successful response' do
        get new_admin_contact_path
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET edit_admin_contact_path' do
      it 'returns successful response' do
        get edit_admin_contact_path(contact)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'POST admin_contacts_path' do
      context 'missing required attributes' do
        it 'raises ParameterMissing' do
          expect do
            post admin_contacts_path, params: {}
          end.to raise_error ActionController::ParameterMissing
        end
      end

      context 'without account' do
        it 'renders error message' do
          post admin_contacts_path, params: {contact: {account_id: ''}}
          expect(response.body).to include 'li>Account must exist</li>'
        end
      end

      context 'with all valid attributes' do
        it 'creates an contact and redirects' do
          expect do
            post admin_contacts_path, params: {contact: {account_id: account.id}}
          end.to change(Contact, :count)

          contact = Contact.order(created_at: :desc).first
          expect(response).to redirect_to admin_contact_path(contact)
        end
      end
    end

    describe 'PATCH admin_contact_path' do
      context 'missing required attributes' do
        it 'raises ParameterMissing' do
          expect do
            patch admin_contact_path(contact), params: {}
          end.to raise_error ActionController::ParameterMissing
        end
      end

      context 'with invalid name' do
        it 'renders error message' do
          patch admin_contact_path(contact), params: {contact: {account_id: ''}}
          expect(response.body).to include 'li>Account must exist</li>'
        end
      end

      context 'with all valid attributes' do
        it 'updates a contact and redirects' do
          patch admin_contact_path(contact), params: {contact: {first_name: 'Updated', last_name: 'Contact'}}

          contact.reload
          expect(contact.first_name).to eq 'Updated'
          expect(contact.last_name).to eq 'Contact'
          expect(response).to redirect_to admin_contact_path(contact)
        end
      end
    end
  end
end
