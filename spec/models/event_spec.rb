require 'rails_helper'

RSpec.describe Event, type: :model do
  context 'with nil attributes' do
    it 'requires browser/ip_address/contact' do
      v = Event.new
      expect(v.valid?).to eq false
      expect(v.errors[:browser]).to include 'must exist'
      expect(v.errors[:contact]).to include 'must exist'
      expect(v.errors[:ip_address]).to include 'must exist'
    end
  end
end
