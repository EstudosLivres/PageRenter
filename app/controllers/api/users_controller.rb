class API::UsersController < API::BaseAPIController
  # Login user By System request (internal dependences)
  def system_signup_signin
    # Except to eliminate the Attr from the Hash (it is a attr to another Model)
    json_received = JSON.parse(params['user'])
    user_hash = json_received.except!('role')
    user_role = json_received['role']
    user = User.new(user_hash)

    unless user.save
     render json:  user.errors.messages.to_json
    end

  end

  # Login user By API request (third dependences)
  def api_signup_signin
    token_manager = API::Concerns::TokenManager.new(params[:email], params[:password], params[:access_token])
    render json: token_manager.token.to_json
  end
end