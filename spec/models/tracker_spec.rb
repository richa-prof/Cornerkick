require 'rails_helper'

RSpec.describe Tracker, type: :model do
  context 'with nil attributes' do
    it 'requires identifier' do
      t = Tracker.new
      t.identifier = nil
      expect(t.valid?).to eq false
      expect(t.errors[:identifier]).to include "can't be blank"
    end
  end
  context 'with basic attributes' do
    let(:account) {Fabricate(:account)}
    let(:basic_params) {{identifier: 'CK-348324834', account: account}}
    it 'creates successfully' do
      t = Tracker.new(basic_params)
      expect(t.save).to eq true
      expect(t.identifier).to eq 'CK-348324834'
    end
  end
end
