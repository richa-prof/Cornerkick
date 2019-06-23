require 'rails_helper'

RSpec.describe TeamMembership, type: :model do
  context 'with nil attributes' do
    it 'requires user/team' do
      membership = TeamMembership.new
      expect(membership.valid?).to eq false
      expect(membership.errors[:user]).to include 'must exist'
      expect(membership.errors[:team]).to include 'must exist'
    end
  end
end
