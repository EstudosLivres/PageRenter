class SocialsController < ApplicationController
  def auth
    # Initializing the env
    network_class = params[:social_network_name].humanize
    network_obj = "Socials::#{network_class}".constantize.new

    # return to the sign_up page if there is no OAuth code
    return redirect_to network_obj.sign_up if params[:code].nil?
    fb_access_token = network_obj.set_up_graph(params[:code])
    session[:fb_access_token] = fb_access_token if session[:fb_access_token].nil?
    user = SocialNetwork.persist_social_user(network_obj)

    # Verify if there is any error
    return render html: {notice: user.errors} if user.errors.messages.is_a?(Hash) if !user.errors.empty?

    session[:user_id] = user.id
    return redirect_to root_url

    render :layout => 'blank'
  end
end
