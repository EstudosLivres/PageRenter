PageRenter::Application.routes.draw do
  root 'redir#index'

  scope '/:idiom' do
    # Blank page with the redir with idiom
    get '' => 'redir#index'

    scope '/publisher' do
      get '' => 'publisher#index'
    end

    scope '/advertiser' do
      get '' => 'advertiser#index'
    end
  end

  namespace :api do
  end
end
