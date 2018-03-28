Rails.application.routes.draw do

  namespace :v1 do
    mount_devise_token_auth_for 'Account', at: 'auth'

    get 'transmissions/confirmed', to: 'transmissions#index', scope: 'confirmed'
    get 'transmissions/started',   to: 'transmissions#index', scope: 'started'
    resources :transmissions, only: %i[index show]

    namespace :admin do
      resources :transmissions      
    end
  end

  as :account do
    # Define routes for Account within this block.
  end
end
