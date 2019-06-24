require 'rails_helper'

RSpec.describe 'campaigns/index', type: :view do
  before(:each) do
    @account = assign(:account, Fabricate(:account))
    @current_account = @account
    campaigns = [
      Fabricate(:campaign,
                name: 'Name',
                account: @account),
      Fabricate(:campaign,
                name: 'Name',
                account: @account)
    ]
    campaigns = Kaminari.paginate_array(campaigns).page(1).per(10)
    assign(:campaigns, campaigns)
  end

  it 'renders a list of campaigns' do
    render
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: false.to_s, count: 2
  end
end
