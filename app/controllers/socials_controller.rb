class SocialsController < ApplicationController
  def auth
    # Initializing the env
    network_class = params[:social_network_name].humanize
    network_obj = "Socials::#{network_class}".constantize.new

    # return to the sign_up page if there is no OAuth code
    return redirect_to network_obj.sign_up if params[:code].nil?
    session[:fb_access_token] = network_obj.set_up_graph(params[:code])

    # TODO just call the user persist based on social_hash
    render :layout => 'blank'
  end
end
