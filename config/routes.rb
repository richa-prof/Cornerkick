Rails.application.routes.draw do
  get 'mockup/mockup'
  devise_for :users

  root :to => 'entry#root'

  mount ShopifyApp::Engine, at: '/'

  namespace :app_proxy do
    root action: 'index'
    # simple routes without a specified controller will go to AppProxyController
    
    # more complex routes will go to controllers in the AppProxy namespace
    # 	resources :reviews
    # GET /app_proxy/reviews will now be routed to
    # AppProxy::ReviewsController#index, for example
  end

  get  'no-account', to: 'entry#no_account', as: :no_account

  resources :accounts, only: [:show] do
    member do
      get 'dashboard'
    end
    collection do
      get 'current_account' => 'accounts#edit_current_account'
      put 'current_account' => 'accounts#update_current_account'
    end
    resources :contacts
    resources :campaigns do
      member do
        post 'generate_urls'
      end
      resources :campaign_ads
      resources :campaign_sources
      resources :campaign_targets
      resources :campaign_urls, only: %i[show edit update destroy]
    end
    resources :groups
    resources :detectors
  end

  namespace :admin do
    resources :accounts
    resources :contacts
    resources :groups
    resources :trackers
    resources :users
  end

  get 'collect/:identifier' => 'collect/tracker#pixel', as: :tracker_pixel
  post 'collect/:identifier' => 'collect/tracker#submission', as: :tracker_submission

  # get 'mockup/mockup'
  # get 'mockup/mvs'
  # get 'mockup/kanban'
  # get 'mockup/login'
  # get 'mockup/creategoal'
  #
  # get 'mockup/leads'
  # get 'mockup/contacts'
  # get 'mockup/contact'


end
