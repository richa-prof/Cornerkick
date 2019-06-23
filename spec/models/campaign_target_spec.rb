require 'rails_helper'

RSpec.describe CampaignTarget, type: :model do
  context 'with nil attributes' do
    it 'requires landing_page' do
      c = CampaignTarget.new
      c.landing_page = nil
      expect(c.valid?).to eq false
      expect(c.errors[:landing_page]).to include "can't be blank"
    end
  end

  context 'with basic attributes' do
    let(:campaign) {Fabricate(:campaign)}
    let(:basic_params) {{landing_page: 'https://www.example.com/landing', campaign: campaign}}
    it 'creates successfully' do
      c = CampaignTarget.new(basic_params)

      expect(c.save).to eq true
      expect(c.campaign).to be_an_instance_of Campaign
      expect(c.account).to be_an_instance_of Account
      expect(c.landing_page).to eq 'https://www.example.com/landing'
    end
  end
end
