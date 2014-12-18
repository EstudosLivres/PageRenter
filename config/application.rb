require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require './app/models/string.rb'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
# ALL THOSE REQUIRES ARE NEEDED BECAUSE I'VE GROUPED EVERY GEM
Bundler.require(*Rails.groups, :useful, :payment, :rails, :user, :services, :build_front_end, :style_and_interactions, :doc)

module PageRenter
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.autoload_paths += %W(#{config.root}/lib)
    config.serve_static_assets = true
    config.to_prepare do
      Devise::SessionsController.layout proc{ |controller| action_name == 'new' ? "sign"   : "application" }
    end

    # Adding the fonts
    config.assets.paths << "#{Rails.root}/app/assets/fonts"

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.default_locale = :'pt-BR'
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
  end
end
