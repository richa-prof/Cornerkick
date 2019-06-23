require 'rails_helper'

RSpec.describe Contact, type: :model do
  context 'with basic attributes' do
    let(:account) {Fabricate(:account)}
    let(:basic_params) {{account: account}}
    let(:contact) {Fabricate(:contact)}
    it 'creates successfully' do
      c = Contact.new(basic_params)

      expect(c.save).to eq true
      expect(c.account).to be_an_instance_of Account
    end

    it 'identifies itself by full_name' do
      expect(contact.display_name).to eq contact.full_name
    end
  end

  context 'is anonymous' do
    let(:anonymous_contact) {Fabricate(:anonymous_contact)}

    it 'identifies itself as anonymous' do
      expect(anonymous_contact.display_name).to eq anonymous_contact.events.last.ip_address.ip_address
    end
  end

  context 'assigned to a group' do
    let(:assigned_group) {Fabricate(:group)}
    let(:unassigned_group) {Fabricate(:group)}
    let(:contact) {Fabricate(:contact, groups: [assigned_group])}

    it 'recognizes membership in assigned group' do
      expect(contact.group?(assigned_group)).to eq true
    end

    it 'disavows membership in unassigned group' do
      expect(contact.group?(unassigned_group)).to eq false
    end

    it 'returns correct array of group names' do
      expect(contact.group_names).to eq [assigned_group.name]
    end

    it 'ignores removing unassigned group' do
      expect do
        contact.remove_group unassigned_group
      end.not_to change(contact.groups, :count)
      expect(contact.groups.count).to eq 1
    end

    it 'successfully removes assigned group' do
      expect do
        contact.remove_group assigned_group
      end.to change(contact.groups, :count)
      expect(contact.groups.count).to eq 0
    end

    it 'retains groups when assigning group_names that already exist' do
      expect do
        contact.group_names = [assigned_group.name]
      end.not_to change(contact.groups, :count)
    end

    it 'replaces groups when assigned a new group_names list' do
      contact.group_names = [unassigned_group.name]
      expect(contact.group_names).to eq [unassigned_group.name]
    end
  end
end
