require 'rails_helper'

RSpec.describe 'detectors', type: :request do
  let(:account) {Fabricate(:account)}
  let(:detector) {Fabricate(:detector, account: account)}

  context 'anonymous' do
    describe 'GET account_detectors_path' do
      it 'requires authentication' do
        get account_detectors_path(account)
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'GET account_detector_path' do
      it 'requires authentication' do
        get account_detector_path(account, detector)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  context 'user is site admin' do
    let(:user) {Fabricate(:user, site_admin: true)}

    before(:each) do
      login_as user
    end

    describe 'GET account_detectors_path' do
      it 'returns HTTP success' do
        get account_detectors_path(account)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET account_detector_path' do
      it 'returns HTTP success' do
        get account_detector_path(account, detector)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'POST account_detectors_path' do
      context 'missing required attributes' do
        it 'raises ParameterMissing' do
          expect do
            post account_detectors_path(account, {})
          end.to raise_error ActionController::ParameterMissing
        end
      end

      context 'with all valid attributes' do
        it 'creates a detector and redirects' do
          expect do
            post account_detectors_path(account), params: {detector: {name: 'detector', description: 'Description'}}
          end.to change(Detector.where(account: account), :count)

          detector = Detector.order(created_at: :desc).first
          expect(detector.name).to eq 'detector'
          expect(response).to redirect_to account_detector_path(account, detector)
        end
      end
    end

    describe 'PATCH account_detector_path' do
      context 'missing required attributes' do
        it 'raises ParameterMissing' do
          expect do
            patch account_detector_path(account, detector), params: {}
          end.to raise_error ActionController::ParameterMissing
        end
      end

      context 'with all valid attributes' do
        it 'updates a detector and redirects' do
          patch account_detector_path(account, detector), params: {detector: {name: 'detector', description: 'Description'}}

          expect(response).to redirect_to account_detector_path(account, detector)
          detector.reload
          expect(detector.name).to eq 'detector'
        end
      end
    end

    describe 'DELETE account_detector_path' do
      it 'deletes specified detector' do
        delete account_detector_path(account, detector)

        expect(Detector.exists?(detector.id)).to eq false
        expect(response).to redirect_to account_detectors_path(account)
      end
    end
  end
end
