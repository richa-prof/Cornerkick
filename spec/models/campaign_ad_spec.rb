require 'rails_helper'

RSpec.describe CampaignAd, type: :model do
  context 'with nil attributes' do
    it 'requires name' do
      c = CampaignAd.new
      c.name = nil
      expect(c.valid?).to eq false
      expect(c.errors[:name]).to include "can't be blank"
    end
  end

  context 'with basic attributes' do
    let(:campaign) {Fabricate(:campaign)}
    let(:basic_params) {{name: 'Name', campaign: campaign}}
    it 'creates successfully' do
      c = CampaignAd.new(basic_params)

      expect(c.save).to eq true
      expect(c.campaign).to be_an_instance_of Campaign
      expect(c.account).to be_an_instance_of Account
      expect(c.name).to eq 'Name'
    end
  end
end
