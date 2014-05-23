PageRenter::Application.routes.draw do
  get 'redirect/index'

  # In a near future put a helper to redirect to the user role session
  root 'redirect#index'

  scope '/users' do
    post 'login' => 'users#login'
    get 'sign_out' => 'users#sign_out'
  end

  # Actions Under/For Publisher
  scope '/publishers' do
    get '' => 'publishers#index'
  end

  # Actions Under/For Advertiser
  scope '/advertisers' do
    get '' => 'advertisers#index'
  end

  # Actions Under/For API (external requests)
  namespace :api do
    # API for Parent/Nested systems (not third systems)
    scope '/system' do
      post '/signup_signin' => 'remote_users#system_signup_signin'
    end

    # All the actions for Thrid and System for MobileApp
    scope '/users' do
      get 'login' => 'remote_users#mob_login'
      post 'login' => 'remote_users#mob_login'
    end
  end
end
