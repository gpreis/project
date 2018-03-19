Rails.application.routes.draw do
  mount_devise_token_auth_for 'Account', at: 'v1/auth'
  as :account do
    # Define routes for Account within this block.
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
