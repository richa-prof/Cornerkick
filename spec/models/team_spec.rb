require 'rails_helper'

RSpec.describe Team, type: :model do
  context 'with nil attributes' do
    it 'requires name' do
      t = Team.new
      t.name = nil
      expect(t.valid?).to eq false
      expect(t.errors[:name]).to include "can't be blank"
    end
  end
end
