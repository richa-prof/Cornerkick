require 'rails_helper'

RSpec.describe 'detectors/edit', type: :view do
  before(:each) do
    @account = assign(:account, Fabricate(:account))
    @detector = assign(:detector, Fabricate(:detector, account: @account))
    @current_account = @account
  end
  before(:each) do
  end

  it 'renders the edit detector form' do
    render

    assert_select 'form[action=?][method=?]', account_detector_path(@account, @detector), 'post' do
      assert_select 'input#detector_name[name=?]', 'detector[name]'

      assert_select 'textarea#detector_description[name=?]', 'detector[description]'
    end
  end
end

