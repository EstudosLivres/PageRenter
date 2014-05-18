class UsersController < ApplicationController
  protect_from_forgery except: :login

  def login
    user_params = params['user']
    User.authenticate(user_params['email'], user_params['password'])
  end

  def sign_out
  end
end
