# encoding: utf-8

# TODO if using Rails 4 or greater use copy and paste on your secret.yml:
# rents:
#   app_id: # TODO your app_id
#   app_secret_key: # TODO your app_secret_key
# IMPORTANT: remember that test & development is not necessary if using test_env, but if you want your test app remember to use you test_app id & secret

# It automatic the RentS to it TestEnv & ProductionEnv
if Rails.env.development? || Rails.env.test?
  # TODO if using Rails 3 or older & not using the TEST_ENV, put here your TEST app_id & your secret_key
  Rents.app_id = ''
  Rents.secret_key = ''

  # TODO: Uncomment test_env if you want to test using RentS default & global app
  # Rents.test_env = true
  # TODO: Uncomment debugger if you have an RentS instance on your machine
  # Rents.debugger = true
elsif Rails.env.production?
  # TODO if using Rails 3 or older, put here your PRODUCTION app_id & your secret_key
  Rents.app_id = ''
  Rents.secret_key = ''

  # For production remember to keep it false or just remove it
  Rents.test_env = false
  Rents.debugger = false
end

# Get your App config if your not using TEST_ENV nor DEBUGGER
if (Rents.test_env.nil? && Rents.debugger.nil?) || (Rents.test_env == false && Rents.debugger == false)
  if Rails.version[0].to_i >= 4
    Rents.app_id = Rails.application.secrets.rents['app_id']
    Rents.secret_key = Rails.application.secrets.rents['app_secret_key']
  end
end
