PageRenter::Application.routes.draw do
  # In a near future put a helper to redirect to the user role session
  root 'publishers#index'

  scope '/users' do
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
  end
end
