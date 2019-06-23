require 'rails_helper'

RSpec.describe DetectorEffect, type: :model do
  context 'with basic attributes' do
    let(:detector) {Fabricate(:detector)}
    let(:basic_params) {{detector: detector}}
    it 'creates successfully' do
      de = DetectorEffect.new(basic_params)
      expect(de.save).to eq true
    end
  end
end
