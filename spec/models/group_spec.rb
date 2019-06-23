require 'rails_helper'

RSpec.describe Group, type: :model do
  context 'with nil attributes' do
    it 'requires name' do
      t = Group.new
      t.name = nil
      expect(t.valid?).to eq false
      expect(t.errors[:name]).to include "can't be blank"
    end
  end

  context 'with basic attributes' do
    let(:account) {Fabricate(:account)}
    let(:basic_params) {{name: 'basic-tag', account: account}}
    it 'creates successfully' do
      t = Group.new(basic_params)

      expect(t.save).to eq true
      expect(t.account).to be_an_instance_of Account
      expect(t.name).to eq 'basic-tag'
    end
  end
end
