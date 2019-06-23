require 'rails_helper'

RSpec.describe Role, type: :model do
  context 'with nil attributes' do
    it 'requires name' do
      r = Role.new
      r.name = nil
      expect(r.valid?).to eq false
      expect(r.errors[:name]).to include "can't be blank"
    end
  end
end
