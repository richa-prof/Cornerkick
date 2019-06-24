require 'rails_helper'

RSpec.describe 'detectors/show', type: :view do
  before(:each) do
    @account = assign(:account, Fabricate(:account))
    @detector = assign(:group, Fabricate(:detector,
                                      name: 'Name',
                                      description: 'Description',
                                      account: @account))
    @current_account = @account
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
  end
end
