require 'rails_helper'

RSpec.describe 'campaigns/show', type: :view do
  before(:each) do
    @account = assign(:account, Fabricate(:account))
    @current_account = @account
    @campaign = assign(:campaign, Fabricate(:campaign, name: 'Name', account: @account))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/false/)
  end
end
