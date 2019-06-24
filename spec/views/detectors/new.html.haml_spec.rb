require 'rails_helper'

RSpec.describe 'detectors/new', type: :view do
  before(:each) do
    @account = assign(:account, Fabricate(:account))
    @current_account = @account
    @detector = assign(:detector, Detector.new(
        name: 'Name',
        description: 'Description'
    ))
  end

  it 'renders new detector form' do
    render

    assert_select 'form[action=?][method=?]', account_detectors_path(@account), 'post' do
      assert_select 'input[name=?]', 'detector[name]'

      assert_select 'textarea[name=?]', 'detector[description]'
    end
  end
end
