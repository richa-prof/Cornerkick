require 'rails_helper'

RSpec.describe Event::Builder, type: :model do
  context 'with basic attributes' do
    let(:account) {Fabricate(:account)}
    let(:builder) {Event::Builder.new(account)}
    it 'successfully creates a visit' do
      event = builder.fingerprint('fingerprint')
                  .user_agent('user-agent')
                  .ip('2001:db8:85a3:8d3:1319:8a2e:370:7348')
                  .url('https://www.cornerkick.io')
                  .referrer('https://www.google.com')
                  .title('Page Title')
                  .remote_host('2001:db8:85a3:8d3:1319:8a2e:370:7348')
                  .build

      expect(event).to_not be nil
      expect(event.browser).to_not be nil
      expect(event.ip_address).to_not be nil
      expect(event.contact).to_not be nil
      expect(event.id).to_not be nil
    end

    it 'keeps the raw string when given invalid JSON' do
      event = builder.fingerprint('fingerprint')
                  .user_agent('user-agent')
                  .ip('2001:db8:85a3:8d3:1319:8a2e:370:7348')
                  .url('https://www.cornerkick.io')
                  .referrer('https://www.google.com')
                  .title('Page Title')
                  .remote_host('2001:db8:85a3:8d3:1319:8a2e:370:7348')
                  .node_properties('{"invalid":"no closing paren"')
                  .build

      expect(event).to_not be nil
      expect(event.browser).to_not be nil
      expect(event.ip_address).to_not be nil
      expect(event.contact).to_not be nil
      expect(event.id).to_not be nil
      expect(event.node_properties).to eq '{"invalid":"no closing paren"'
    end
  end

end
