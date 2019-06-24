require 'rails_helper'
require 'securerandom'

RSpec.describe 'submission_tracker', type: :request do
  let(:valid_account) {Fabricate(:account)}
  let(:tracker) {Fabricate(:tracker, account: valid_account)}
  let(:valid_contact) {Fabricate(:contact, account: valid_account)}

  let(:fingerprint) {SecureRandom.uuid}

  let(:browser) do
    Fabricate(:browser, contact: valid_contact)
  end

  describe 'POST #submission' do
    context 'first time seen contact' do
    end

    context 'previously seen contact' do
    end
  end
end
