require 'rails_helper'

RSpec.describe Account, type: :model do
  context 'with nil attributes' do
    it 'requires name' do
      a = Account.new
      a.name = nil
      expect(a.valid?).to eq false
      expect(a.errors[:name]).to include "can't be blank"
    end
  end
  context 'with basic attributes' do
    let(:basic_params) {{name: 'Uno'}}
    it 'creates successfully' do
      a = Account.new(basic_params)
      expect(a.save).to eq true
      expect(a.name).to eq 'Uno'
    end
  end
end
