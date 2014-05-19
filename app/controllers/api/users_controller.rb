class API::UsersController < API::BaseAPIController
  # Login user By System request (internal dependences)
  def system_signup_signin
    # Except to eliminate the Attr from the Hash (it is a attr to another Model)
    input_hash = params['user']
    # Parse JSON String to Hash, if it is a String
    input_hash = JSON.parse(input_hash) if input_hash.is_a?String

    # user_hash depends if it was by form or by Social Login (input_hash.has_key?(social_key)=true ->SocialLogin else Form)
    social_key = 'social_session'
    is_social_login = input_hash.has_key?(social_key)
    if is_social_login
      temp_hash = User.create_user_hash_from_social(input_hash[social_key])
      social_hash = temp_hash[:social_session]
      user_hash = temp_hash[:user]
    else user_hash = input_hash end

    # SELECT user WHERE email OR :email
    user = User.find_by_email([user_hash['email'],user_hash[:email]])

    # SignUp
    if user.nil?
      user = User.create_one_user(user_hash)

      # User save
      if user.save
        # More insertions if SocialLogin
        unless social_hash.nil? then social_hash['user_id'] = user.id end
        if is_social_login then SocialSession.where(social_hash).first_or_create end

        # Prepair the response
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

    # Send the response
    render json: response
  end

  # Login user By API request (third dependences)
  def api_signup_signin
    token_manager = API::Concerns::TokenManager.new(params[:email], params[:password], params[:access_token])
    render json: token_manager.token.to_json
  end
end