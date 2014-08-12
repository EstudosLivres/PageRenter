class SocialsController < ApplicationController
  def auth
    # Initializing the env
    network_class = params[:social_network_name].humanize
    network_obj = "Socials::#{network_class}".constantize.new
    return redirect_to network_obj.sign_up if params[:code].nil?
    session[:fb_access_token] = network_obj.set_up_graph(params[:code])

    # Setting the vars to be used on the View
    @network_login_url = network_obj.sign_up
    @network_login_url
    render :layout => 'blank'
  end
end
