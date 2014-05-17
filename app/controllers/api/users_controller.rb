class API::UsersController < API::BaseAPIController
  # Login user By System request (internal dependences)
  def system_signup_signin

  end

  # Login user By API request (third dependences)
  def api_signup_signin
    token_manager = API::Concerns::TokenManager.new(params[:email], params[:password], params[:access_token])
    render json: token_manager.token.to_json
  end
end