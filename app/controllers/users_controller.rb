class UsersController < ApplicationController
  protect_from_forgery except: :login

  def login
    user_params = params['user']
    user = User.authenticate(user_params['email'], user_params['password'])
    if user
      # Create the LogIn Flash
      flash[:notice] = { type: :success, strong: t(:msgs)[:login_success_strong], msg: t(:msgs)[:login_success] }
      flash.keep

      session[:user_id] = user.id
      redirect_to :controller =>  user.get_default_profile.role.name.pluralize
    else
      redirect_to ApplicationController.land_url
    end
  end

  def sign_out
    # Do not delete all the sessions because we need to storage the link clicked
    session.delete('user_id')
    session.delete('user_idiom')
    redirect_to ApplicationController.land_url
  end
end
