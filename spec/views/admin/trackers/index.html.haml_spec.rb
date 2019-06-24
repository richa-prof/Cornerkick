require 'rails_helper'

RSpec.describe 'admin/trackers/index', type: :view do
  let(:account) { Fabricate(:account) }
  before(:each) do
    trackers = [
      Fabricate(:tracker, account: account, identifier: 'Identifier'),
      Fabricate(:tracker, account: account, identifier: 'Identifier')
    ]
    trackers = Kaminari.paginate_array(trackers).page(1).per(10)
    assign(:trackers, trackers)
  end

  it 'renders a list of trackers' do
    render
    assert_select 'tr>td', text: 'Identifier'.to_s, count: 2
    assert_select 'tr>td', text: account.name, count: 2
  end
end
