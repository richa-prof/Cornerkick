require 'rails_helper'

RSpec.describe 'admin/trackers/new', type: :view do
  before(:each) do
    assign(:tracker, Tracker.new)
  end

  it 'renders new tracker form' do
    render

    assert_select 'form[action=?][method=?]', admin_trackers_path, 'post' do
      assert_select 'input[name=?]', 'tracker[identifier]'

      assert_select 'select[name=?]', 'tracker[account_id]'
    end
  end
end
