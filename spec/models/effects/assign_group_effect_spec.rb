require 'rails_helper'

RSpec.describe Effects::AssignGroupEffect, type: :model do

  context 'with campaign url' do
    let(:account) {Fabricate(:account)}
    let(:contact) {Fabricate(:contact, account: account)}
    let(:group) {Fabricate(:group, account: account)}
    let(:event) {Fabricate(:event, url: 'https://www.example.com/path/to/thing?param1=bunnies', contact: contact)}
    let(:detector) {Fabricate(:detector, account: account)}

    let(:effect) {Effects::AssignGroupEffect.new(detector: detector)}

    describe 'apply' do

      it 'assigns group' do
        effect.settings['group_id'] = group.id
        effect.startup
        effect.apply event

        expect(contact.group? group).to eq true
      end
    end

  end
end
