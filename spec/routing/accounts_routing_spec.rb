require 'rails_helper'

RSpec.describe AccountsController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/accounts/1').to route_to('accounts#show', id: '1')
    end

    it 'routes to #dashboard' do
      expect(get: '/accounts/1/dashboard').to route_to('accounts#dashboard', id: '1')
    end

    it 'routes to #edit_current_account' do
      expect(get: '/accounts/current_account').to route_to('accounts#edit_current_account')
    end

    it 'routes to #update_current_account' do
      expect(put: '/accounts/current_account').to route_to('accounts#update_current_account')
    end
  end
end
