require 'rails_helper'

RSpec.describe Campaign, type: :model do
  describe 'campaign creation' do
    context 'with nil attributes' do
      it 'requires name' do
        c = Campaign.new
        c.name = nil
        expect(c.valid?).to eq false
        expect(c.errors[:name]).to include "can't be blank"
      end
    end

    context 'with basic attributes' do
      let(:account) {Fabricate(:account)}
      let(:basic_params) {{name: 'basic-campaign', account: account}}
      it 'creates successfully' do
        c = Campaign.new(basic_params)

        expect(c.save).to eq true
        expect(c.account).to be_an_instance_of Account
        expect(c.name).to eq 'basic-campaign'
      end
    end
  end

  describe '#generate_campaign_urls' do
    context 'with one target/source/ad' do
      let(:campaign) do
        c = Fabricate(:campaign)
        Fabricate(:campaign_target, campaign: c)
        Fabricate(:campaign_source, campaign: c)
        Fabricate(:campaign_ad, campaign: c)
        c
      end

      it 'generates a single url' do
        campaign.generate_campaign_urls
        expect(campaign.campaign_urls.count).to eq 1
      end

      it 'does not duplicate generated url when called twice' do
        campaign.generate_campaign_urls
        campaign.generate_campaign_urls
        expect(campaign.campaign_urls.count).to eq 1
      end
    end
  end

  describe '#locate_campaign' do
    let(:campaign) {Fabricate(:campaign, name: 'known_campaign_name')}

    context 'empty parameters' do
      let(:uri) {URI('http://parameterless.com/with/a/path')}
      it 'returns nil' do
        expect(Campaign.locate_campaign(uri)).to be_nil
      end
    end

    context 'parameters but no campaign param' do
      let(:uri) {URI('http://parameters.com/with/a/path?param1=value&param2=value')}
      it 'returns nil' do
        expect(Campaign.locate_campaign(uri)).to be_nil
      end
    end

    context 'campaign param in parameters but no matching campaign' do
      let(:uri) {URI('http://parameters.com/with/a/path?utm_campaign=unmatched&other-stuff=xyz')}

      it 'returns nil' do
        expect(Campaign.locate_campaign(uri)).to be_nil
      end
    end

    context 'campaign param in parameters with campaign' do
      let(:uri) {URI('http://parameters.com/with/a/path?utm_campaign=known_campaign_name&other-stuff=xyz')}

      it 'returns campaign instance' do
        name = campaign.name
        found = Campaign.locate_campaign(uri)
        expect(found).to_not be_nil
        expect(found.name).to eq(name)
      end
    end
  end

  describe '#process_visit' do
    let(:account) {Fabricate(:account)}
    let(:contact) {Fabricate(:contact, account: account)}
    let(:group) {Fabricate(:group, account: account)}
    let(:other_group) {Fabricate(:group, account: account)}
    let(:campaign) {Fabricate(:campaign, account: account, name: 'name')}

    context 'visit matches' do
      let(:url) {Fabricate(:campaign_url, campaign: campaign, group: group)}
      let(:visit) {Fabricate(:event, url: url.url, contact: contact)}
      it 'assigns group to contact' do
        Campaign.process_visit(visit)
        contact.reload
        expect(contact.group?(group)).to be true
      end
    end

    context 'visit does not match' do
      let(:unmatched_url) {Fabricate(:campaign_url, campaign: campaign, group: other_group)}
      let(:visit) {Fabricate(:event, url: unmatched_url.url, contact: contact)}
      it 'does not assign group to contact' do
        Campaign.process_visit(visit)
        contact.reload
        expect(contact.group?(group)).to be false
      end
    end
  end
end
