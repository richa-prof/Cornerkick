require 'rails_helper'

RSpec.describe Grouping, type: :model do
  context 'with nil attributes' do
    it 'requires a group and contact' do
      g = Grouping.new
      expect(g.valid?).to eq false
      expect(g.errors[:contact]).to include 'must exist'
      expect(g.errors[:group]).to include 'must exist'
    end
  end

  context 'with basic attributes' do
    let(:account) {Fabricate(:account)}
    let(:group) {Fabricate(:group, account: account)}
    let(:contact) {Fabricate(:contact, account: account)}
    let(:basic_params) {{group: group, contact: contact}}
    it 'creates successfully' do
      g = Grouping.new(basic_params)

      expect(g.save).to eq true
      expect(g.contact).to be_an_instance_of Contact
      expect(g.group).to be_an_instance_of Group
    end
  end
end
