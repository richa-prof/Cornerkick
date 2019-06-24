require 'rails_helper'

RSpec.describe 'admin/trackers/edit', type: :view do
  before(:each) do
    @tracker = assign(:tracker, Fabricate(:tracker))
  end

  it 'renders the edit tracker form' do
    render

    assert_select 'form[action=?][method=?]', admin_tracker_path(@tracker), 'post' do
      assert_select 'input[name=?]', 'tracker[identifier]'

      assert_select 'select[name=?]', 'tracker[account_id]'
    end
  end
end
