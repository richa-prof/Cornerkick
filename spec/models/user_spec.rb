require 'rails_helper'

RSpec.describe User, type: :model do
  context 'with nil attributes' do
    it 'requires email' do
      u = User.new
      u.email = nil
      expect(u.valid?).to eq false
      expect(u.errors[:email]).to include "can't be blank"
    end
  end
end
