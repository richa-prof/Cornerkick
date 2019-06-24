require 'rails_helper'

RSpec.describe 'detectors/index', type: :view do
  before(:each) do
    @account = assign(:account, Fabricate(:account))
    @current_account = @account
    detectors = [
        Fabricate(:detector,
                  name: 'Name',
                  description: 'Description',
                  account: @account),
        Fabricate(:detector,
                  name: 'Name',
                  description: 'Description',
                  account: @account)
    ]
    detectors = Kaminari.paginate_array(detectors).page(1).per(10)
    assign(:detectors, detectors)
  end

  it 'renders a list of detectors' do
    render
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: 'Description'.to_s, count: 2
  end
end
