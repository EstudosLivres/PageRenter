PageRenter::Application.routes.draw do
  # In a near future put a helper to redirect to the user role session
  root 'publishers#index'

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
      post '/signup_signin' => 'users#system_signup_signin'
    end

    # API for Thirds
    post '/signup_signin' => 'users#api_signup_signin'
  end
end
