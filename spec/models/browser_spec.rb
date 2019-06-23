require 'rails_helper'

RSpec.describe Browser, type: :model do
  context 'with nil attributes' do
    it 'requires fingerprint' do
      b = Browser.new
      expect(b.valid?).to eq false
      expect(b.errors[:fingerprint]).to include "can't be blank"
    end
  end
  context 'with basic attributes' do
    let(:contact) {Fabricate(:contact)}
    let(:basic_params) {{fingerprint: 'fingerprint', contact: contact}}
    it 'creates successfully' do
      b = Browser.new(basic_params)
      expect(b.save).to eq true
      expect(b.fingerprint).to eq basic_params[:fingerprint]
    end
  end
end
