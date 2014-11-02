class API::RemoteUsersController < API::BaseAPIController
  # Login user By System request (internal dependencies)
  def system_sign_up_sign_in
    user = User.new_user_with_it_role(user_params)
    if user.save
      return render json: {status: 'ok', msg: 'registered'}
    else
      return render json: {status: 'error', type: :invalid_attr_value, msg: user.errors.messages.to_json}
    end
  end

  # POST api/admins/login
  def admin_check_login
    user = User.authenticate(params[:username], params[:password])
    session[:user_id] = user.id if !user.nil? && user.is_a?(User)

    if user.errors.messages.empty? then return render json: {status: 'ok', msg: 'loged_in'}
    else return render json: {status: 'error', type: :invalid_attr_value, msg: user.errors.messages.to_json} end
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

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    user = RailsFixes::Util.hash_keys_to_sym(JSON.parse(params.require(:user)))
    return {name:user[:name], username:user[:username], email:user[:email], locale:user[:locale], password:user[:password], role:user[:role]}
  end
end