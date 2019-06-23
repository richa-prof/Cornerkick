require 'rails_helper'

RSpec.describe Detector, type: :model do
  context 'with nil attributes' do
    it 'requires name' do
      a = Detector.new
      a.name = nil
      expect(a.valid?).to eq false
      expect(a.errors[:name]).to include "can't be blank"
    end
  end

  context 'with basic attributes' do
    let(:account) {Fabricate(:account)}
    let(:basic_params) {{name: 'Uno', account: account}}
    it 'creates successfully' do
      a = Detector.new(basic_params)
      expect(a.save).to eq true
      expect(a.name).to eq 'Uno'
    end
  end

  context 'with basic condition and effects' do
    let(:account) {Fabricate(:account)}
    let(:contact) {Fabricate(:contact, account: account)}
    let(:campaign) {Fabricate(:campaign, account: account, name: 'name')}
    let(:url) {Fabricate(:campaign_url, campaign: campaign)}
    let(:event) {Fabricate(:event, url: url.url, contact: contact)}
    let(:detector) {
      detector = Detector.new({name: 'basic', account: account})
      condition = Conditions::AlwaysTrueCondition.new(detector: detector)
      detector.detector_conditions << condition
      effect = Effects::NoOpEffect.new(detector: detector)
      detector.detector_effects << effect
      detector.save
      detector
    }

    describe 'process_event' do

      it 'process event creates a note' do
        result = detector.process_event(event)
        expect(result.detector_result_notes.count).to eq 2
      end
    end

  end
end
