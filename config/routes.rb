PageRenter::Application.routes.draw do
  get 'redirect/index'

  # In a near future put a helper to redirect to the user role session
  root 'redirect#redirect_index'

  scope '/users' do
    post 'login' => 'users#login'
    get 'sign_out' => 'users#sign_out'
  end

  # Actions Under/For Publisher
  scope '/publishers' do
    get '' => 'publishers#index'
    get '/edit' => 'publishers#edit'
  end

  # Actions Under/For Advertiser
  scope '/advertisers' do
    get '' => 'advertisers#index'
    get '/edit' => 'advertisers#edit'
    resources :campaigns
  end

  # Actions Under/For API (external requests)
  namespace :api do
    # Documentation and easy edition for the Developer usage
    scope 'console' do
      get '' => 'console#index'
      get 'docs' => 'console#documentation'
    end

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
