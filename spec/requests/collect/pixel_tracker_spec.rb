require 'rails_helper'
require 'securerandom'

RSpec.describe 'pixel_tracker', type: :request do
  let(:valid_account) {Fabricate(:account)}
  let(:tracker) {Fabricate(:tracker, account: valid_account)}
  let(:valid_contact) {Fabricate(:contact, account: valid_account)}

  let(:fingerprint) {SecureRandom.uuid}

  let(:browser) do
    Fabricate(:browser, contact: valid_contact)
  end

  describe 'GET #pixel' do
    context 'first time seen contact' do
      it 'creates new contact and records visit' do
        expect do
          get tracker_pixel_path(identifier: tracker.identifier), params: {cf: fingerprint}
        end.to change Contact, :count
        expect(response).to have_http_status(:success)

        b = Browser.find_by(fingerprint: fingerprint)
        expect(b).to_not be nil

        expect(b.contact.account).to eq valid_account
        expect(b.events.count).to eq 1

        expect(response.body).to eq Cornerkick::PIXEL_IMG
      end
    end

    context 'visit from previously seen contact' do
      it 'records new visit for existing contact' do
        expect do
          get tracker_pixel_path(identifier: tracker.identifier), params: {cf: browser.fingerprint}
        end.to change Event.where(browser: browser), :count
      end
    end
  end
end
