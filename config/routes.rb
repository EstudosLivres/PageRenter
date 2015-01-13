PageRenter::Application.routes.draw do
  root to: 'home#index' # it must be just a redirect (like a facade)

  # DeviseUser sessions
  devise_for :users, controllers: {registrations:'users/registrations', sessions:'users/sessions', passwords:'users/passwords'}
  devise_scope :users do
    resource :registrations, only: [:new, :create, :edit, :update]
  end

  # Actions Under/For Admin
  scope '/admins' do
    get '' => 'admins#index', as: :admin_root
    get 'sign_in' => 'admins#login', as: :admin_login
    get 'ad_analyse' => 'admins#ad_analyse', as: :admin_ad_analyse # TODO (Criar conceito melhor disso)
    resources :banned_ad_histories
    resources :segments do
      get 'add_range' => 'segments#add_range', as: :add_range
      post 'improve_range' => 'segments#improve_range', as: :improve_range
    end
  end

  # Actions Under/For Advertiser
  scope '/advertisers' do
    get '' => 'advertisers#index', as: :advertiser_root
    get '/edit' => 'advertisers#edit', as: :advertiser_edit
    get '/report_record' => 'reports#campaigns', as: :advertiser_report_record
    patch '/update' => 'advertisers#update'
    # TODO create Briefing resource
    get '/briefing' => 'advertisers#index', as: :create_briefing
    resources :campaigns, except: [:destroy] do
      # Budget scope
      resources :budgets, except: [:edit, :destroy]
      resources :ad_history_states, only: [:show, :index, :restart, :pause]

      # Ad scope
      resources :ads, except: [:destroy] do
        resources :ad_history_states, only: [:show]
        resources :accesses, only: [:index, :show]
        resources :bids, except: [:destroy]
      end
    end
  end

  # Actions Under/For Publisher
  scope '/publishers' do
    get '' => 'publishers#index', as: :publisher_root
    get '/edit' => 'publishers#edit', as: :publisher_edit
    get '/add_social_auth' => 'publishers#add_social_auth', as: :add_social_auth
    get '/accesses/:campaign_id/:publisher_username/:ad_username' => 'accesses#brought', as: :publisher_brought_access
    get '/report_record' => 'reports#brought_accesses', as: :publisher_report_record
  end

  # Actions Under/For SocialOptions
  scope '/socials' do
    # Post back from the socials network after validate user
    get 'auth/:social_network_name' => 'socials#auth', as: :social_auth
  end

  # Reports/Charts/Statistics about performance
  scope 'reports' do
    get '' => 'reports#index'
    get 'campaigns' => 'reports#campaigns'
    get 'brought_accesses' => 'reports#brought_accesses'
  end

=begin
  TODO developer.pagerenter must be a WordPressApp with /docs & /blog & /reference
=end

  # Actions Under/For API (external requests)
  namespace :api do
    # Useful configuration interface (the unique part of the API which have GUI)
    scope 'console' do
      get '' => 'console#dashboard'
      get 'docs' => 'console#documentation'
    end

    # API for PageRenter Parent/Nested systems/apps, it isn't for third systems
    scope '/system' do
      post '/sign_up_sign_in' => 'remote_users#system_sign_up_sign_in'
      get '/social/login/:social_network_name' => 'remote_users#social_login'

      # All the actions that generate data
      scope '/generators' do
        get 'shorter' => 'generator#shorter', as: :shorter_generator
        get 'social/share(/:social_network)' => 'generator#social', as: :social_generator # TODO if not passed social_network retrieve all links generated? Check login for those actions?
      end
    end

    # All the actions for ThirdDevelopers are under versions
    scope '/v1' do
      scope '/users' do
        get 'login' => 'remote_users#mob_login'
        post 'login' => 'remote_users#mob_login'
        get 'admin_login' => 'remote_users#admin_check_login'
        post 'admin_login' => 'remote_users#admin_check_login', as: :admin_check_login
      end
    end
  end
end
