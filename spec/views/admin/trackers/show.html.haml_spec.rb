require 'rails_helper'

RSpec.describe 'admin/trackers/show', type: :view do
  before(:each) do
    @tracker = assign(:tracker, Fabricate(:tracker, identifier: 'Identifier'))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Identifier/)
    expect(rendered).to match(//)
  end
end
