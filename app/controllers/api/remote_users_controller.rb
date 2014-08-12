class API::RemoteUsersController < API::BaseAPIController
  # Login user By System request (internal dependences)
  def system_sign_up_sign_in

  end

  # Login by token, without session
  def mob_login
    token_manager = API::Concerns::TokenManager.new(params[:email], params[:password], params[:access_token])
    current_user = token_manager.current_user
    if !current_user.nil?
      render json: JSON.parse(current_user.to_json).except('id', 'password', 'pass_salt', 'updated_at')
    else
      render json: JSON.parse(token_manager.token.to_json)
    end
  end

  # SocialNetwork Logins
  def social_login
    # Initializing the env
    network_class = params[:social_network_name].humanize
    network_obj = "Socials::#{network_class}".constantize.new

    # Setting the vars to be used on the View
    @network_login_url = network_obj.sign_up
    render json: {url: @network_login_url}
  end
end