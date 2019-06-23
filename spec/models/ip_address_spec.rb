require 'rails_helper'

RSpec.describe IpAddress, type: :model do
  context 'with nil attributes' do
    it 'requires ip_address' do
      ip = IpAddress.new
      ip.ip_address = nil
      expect(ip.valid?).to eq false
      expect(ip.errors[:ip_address]).to include "can't be blank"
    end
  end
end
