class API::UsersController < API::BaseAPIController

  # Logar o usuário via token
  def login
    token_manager = API::Concerns::TokenManager.new(params[:email], params[:password], params[:access_token])
    render json: token_manager.token.to_json
  end

end