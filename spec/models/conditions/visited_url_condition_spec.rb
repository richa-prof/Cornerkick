require 'rails_helper'

RSpec.describe Conditions::VisitedUrlCondition, type: :model do

  context 'with campaign url' do
    let(:account) {Fabricate(:account)}
    let(:contact) {Fabricate(:contact, account: account)}
    let(:event) {Fabricate(:event, url: 'https://www.example.com/path/to/thing?param1=bunnies', contact: contact)}
    let(:detector) {Fabricate(:detector, account: account)}

    let(:condition) {Conditions::VisitedUrlCondition.new(detector: detector)}

    describe 'check' do

      it 'detects url' do
        condition.settings['url'] = 'https://www.example.com/path/to/thing'
        condition.settings['params'] = {
            'param1': 'bunnies'
        }
        response = condition.check event
        expect(response).to eq true
      end
    end

  end
end
