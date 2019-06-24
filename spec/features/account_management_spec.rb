require 'rails_helper'

RSpec.feature 'Account management', type: :feature do
  let(:valid_user) {Fabricate(:user)}

  before(:each) do
    Fabricate(:account)
  end

  scenario 'User views all accounts' do
    visit '/users/sign_in'

    within('#new_user') do
      fill_in 'Email', with: valid_user.email
      fill_in 'Password', with: valid_user.password
    end
    click_button 'Log in'

    visit '/admin/accounts'

    expect(current_path).to eq '/admin/accounts'
  end
end
