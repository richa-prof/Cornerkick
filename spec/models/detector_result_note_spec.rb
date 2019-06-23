require 'rails_helper'

RSpec.describe DetectorResultNote, type: :model do
  context 'with basic attributes' do
    let(:result) {Fabricate(:detector_result)}
    let(:condition) {Fabricate(:detector_condition)}
    let(:basic_params) {{detector_result: result, scribe: condition}}
    it 'creates successfully' do
      note = DetectorResultNote.new(basic_params)
      expect(note.save).to eq true
    end
  end
end
