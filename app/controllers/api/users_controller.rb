class API::UsersController < API::BaseAPIController
  # Login user By System request (internal dependences)
  def system_signup_signin
    # Except to eliminate the Attr from the Hash (it is a attr to another Model)
    user_hash = JSON.parse(params['user'])
    user = User.find_by_email(user_hash['email'])

    # SignUp
    if user.nil?
      user = User.create_one_user(user_hash)
      if user.save
        response = { status: 'ok', msg: 'registered' }
        # Manage the Token
        API::Concerns::TokenManager.new(user.email, user.password, params[:access_token])
      else
        response =  { status: 'error', msg: user.errors.messages.to_json }
      end

    # SignIn
    else
      User.authenticate(user_hash['email'], user_hash['password'])
      response = { status: 'ok', msg: 'logged_in' }
    end

    render json: response
  end

  # Login user By API request (third dependences)
  def api_signup_signin
    token_manager = API::Concerns::TokenManager.new(params[:email], params[:password], params[:access_token])
    render json: token_manager.token.to_json
  end
end