require 'rails_helper'

RSpec.describe CampaignUrl, type: :model do
  let(:account) {Fabricate(:account)}
  let(:contact) {Fabricate(:contact, account: account)}
  let(:group) {Fabricate(:group, account: account)}
  let(:campaign) {Fabricate(:campaign, account: account, name: 'name')}
  let(:url) {Fabricate(:campaign_url, campaign: campaign, group: group)}

  describe '#process_visit' do
    context 'visit matches' do
      context 'grouped url' do
        let(:visit) {Fabricate(:event, url: url.url, contact: contact)}
        it 'assigns group to contact' do
          url.process_visit(visit)
          contact.reload
          expect(contact.group?(group)).to be true
        end
      end

      context 'groupless url' do
        let(:groupless_url) {Fabricate(:campaign_url, campaign: campaign)}
        let(:visit) {Fabricate(:event, url: groupless_url.url, contact: contact)}
        it 'does not assign group to contact' do
          groupless_url.process_visit visit
          contact.reload
          expect(contact.groupings.count).to eq 0
        end
      end
    end

    context 'visit does not match' do
      let(:unmatched_url) {Fabricate(:campaign_url, campaign: campaign, group: group)}
      let(:visit) {Fabricate(:event, url: unmatched_url.url, contact: contact)}
      it 'does not assign group to contact' do
        url.process_visit(visit)
        contact.reload
        expect(contact.group?(group)).to be false
      end
    end
  end
end
