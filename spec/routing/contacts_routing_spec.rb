require 'rails_helper'

RSpec.describe ContactsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/accounts/1/contacts').to route_to('contacts#index', account_id: '1')
    end

    it 'routes to #new' do
      expect(get: '/accounts/1/contacts/new').to route_to('contacts#new', account_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/accounts/1/contacts/1').to route_to('contacts#show', account_id: '1', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/accounts/1/contacts/1/edit').to route_to('contacts#edit', account_id: '1', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/accounts/1/contacts').to route_to('contacts#create', account_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/accounts/1/contacts/1').to route_to('contacts#update', account_id: '1', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/accounts/1/contacts/1').to route_to('contacts#update', account_id: '1', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/accounts/1/contacts/1').to route_to('contacts#destroy', account_id: '1', id: '1')
    end
  end
end
