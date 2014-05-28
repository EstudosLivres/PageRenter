class RedirectController < ApplicationController
  def redirect_index
    loged_user = User.find(session['user_id']) unless session['user_id'].nil?

    if !loged_user.nil?
      default_role = Profile.get_default_role(loged_user.profiles)
      redirect_to :controller => "#{default_role}s", :action => 'index'
    else
      # Redirect to the land
      redirect_to ApplicationController.land_url
    end
  end
end
