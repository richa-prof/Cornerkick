require 'rails_helper'

RSpec.describe RoleAssignment, type: :model do
  context 'with nil attributes' do
    it 'requires account/user/role' do
      assignment = RoleAssignment.new
      expect(assignment.valid?).to eq false
      expect(assignment.errors[:user]).to include 'must exist'
      expect(assignment.errors[:account]).to include 'must exist'
      expect(assignment.errors[:role]).to include 'must exist'
    end
  end
end
