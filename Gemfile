source 'https://rubygems.org'
ruby '2.1.2'

# 'util' Useful in some context like better print/puts or legal_id like CPF
group :useful do
  # Gem for encrypt Password
  gem 'bcrypt', :require => 'bcrypt'

  # Color to the prints on console (PUTS)
  gem 'colorize', '~> 0.7.1'

  # To easy consume REST API
  gem 'rest-client', '~> 1.7.2'
end

# PaymentMethods
group :payment do
  # PaymentMethod
  gem 'rents', '~> 0.1.10'
  gem 'spring', '~> 1.1.3'
end

# GEMs for default rails apps
group :rails do
  # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
  gem 'rails', '4.1.7'

  # Use mysql as the database for Active Record
  gem 'mysql2'

  # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
  gem 'turbolinks'

  # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
  gem 'jbuilder', '~> 1.2'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', platforms: :ruby
end

# GEMs for user infos
group :user do
  # For easy user session management
  gem 'devise', '~> 3.4.1'

  # Gem to Query on the Facebook (FQL)
  gem 'fql', '~> 0.3.1'

  # Full Facebook API (including Graph API)
  gem "koala", "~> 1.10.0rc"

  # For global usage of Google API services, like Google+ & the URLShorter (Goo.gl)
  gem 'google-api-client', '~> 0.7.1'
end

# GEMs with we use as client of it services
group :services do
  # Gem for UPLOAD files
  gem 'paperclip', '~> 4.2.0'
  gem 'aws-sdk', '~> 1.58.0'
  gem 's3_direct_upload', '~> 0.1.7'
end

# GEMs for build the view
group :build_front_end do
  # Easier & faster then ERB
  gem 'slim-rails', '~> 2.1.5'

  # GoogleMaps GEM (using Google maps API V3)
  gem 'gmaps4rails', '~> 2.1.2'

  # Use SCSS for stylesheets
  gem 'sass-rails', '~> 4.0.0'

  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '>= 1.3.0'

  # Use CoffeeScript for .js.coffee assets and views
  gem 'coffee-rails', '~> 4.0.0'

  # for the social-buttons
  gem 'jasny_bundle', '~> 2.1.0'
end

# Style & Interactions view frameworks
group :style_and_interactions do
  # ZeroClipBoard (easy copy to memory - command+c)
  gem 'zeroclipboard-rails', '~> 0.1.0'

  # jQuery for Rails & it UI
  gem 'jquery-rails'
  gem 'jquery-ui-rails'

  # Bootstrap & it dependencies Date picker for bootstrap (easy calendar)
  gem 'less-rails', '~> 2.6.0'
  gem 'less-rails-bootstrap', '~> 3.3.0.1'
  gem 'bootstrap-datepicker-rails', '~> 1.3.0.2'

  # Gem for Bootstrap with material design
  # TODO gem 'bootstrap-material-design', '~> 0.1.4'

  # IconFonts - FontAwesome
  gem 'font-awesome-rails', '~> 4.2.0.0'

  # IconFonts - Zurb
  gem 'zurb-foundation', '~> 4.3.2'

  # IconFonts with it Buttons layout
  gem 'social-buttons', '~> 0.3.9'
end

# Generate documentation
group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Just for production like on Heroku
gem 'rails_12factor', group: :production

# GEMs to work only on test & development environments
group :development, :test do
  # RSPec for BDD pratices
  gem 'rspec-rails', '~> 2.14.1'

  # Better Errors for fast debug from the view on the browser
  gem 'better_errors', '~> 1.1.0'

  # Plugin for better errors
  gem 'binding_of_caller', '~> 0.7.2'

  # Option to not use Fixtures (FactoryGirl)
  gem 'factory_girl_rails', require:false

  # Create readable attrs values
  gem 'faker', '~> 1.4.2'

  # RSPec Plugin for testing Views
  gem 'capybara', '~> 2.2.1'

  # RSPec Plugin for code-coverage
  gem 'simplecov', '~> 0.7.1'

  # RSPec Plugin for params on its
  gem 'its'
end