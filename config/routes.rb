PageRenter::Application.routes.draw do
  # In a near future put a helper to redirect to the user role session
  root 'publisher#index'

  # Actions Under/For Publisher
  scope '/publisher' do
    get '' => 'publisher#index'
  end

  # Actions Under/For Advertiser
  scope '/advertiser' do
    get '' => 'advertiser#index'
  end

  # Actions Under/For API (external requests)
  namespace :api do
  end
end
