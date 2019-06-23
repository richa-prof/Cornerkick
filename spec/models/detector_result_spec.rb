require 'rails_helper'

RSpec.describe DetectorResult, type: :model do
  context 'with basic attributes' do
    let(:detector) {Fabricate(:detector)}
    let(:event) {Fabricate(:event)}
    let(:basic_params) {{detector: detector, event: event}}
    it 'creates successfully' do
      dr = DetectorResult.new(basic_params)
      expect(dr.save).to eq true
    end
  end
end
