require 'rails_helper'

RSpec.describe DetectorCondition, type: :model do
  context 'with basic attributes' do
    let(:detector) {Fabricate(:detector)}
    let(:basic_params) {{detector: detector}}
    it 'creates successfully' do
      dc = DetectorCondition.new(basic_params)
      expect(dc.save).to eq true
    end
  end
end
