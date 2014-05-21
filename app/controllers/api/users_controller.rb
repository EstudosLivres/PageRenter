class API::UsersController < API::BaseAPIController
  # Login user By System request (internal dependences)
  def system_signup_signin
    # Except to eliminate the Attr from the Hash (it is a attr to another Model)
    input_hash = params['user']
    # Parse JSON String to Hash, if it is a String and abort if no user hash received
    if(input_hash.is_a?(String) && input_hash.length <= 1) then return render json: { status: 'error', type: :no_user_data, msg: 'No user Data received!' } end
    input_hash = JSON.parse(input_hash) if input_hash.is_a?String

    # user_hash depends if it was by form or by Social Login (input_hash.has_key?(social_key)=true ->SocialLogin else Form)
    social_key = 'social_session'
    is_social_login = input_hash.has_key?(social_key)
    if is_social_login
      temp_hash = User.create_user_hash_from_social(input_hash[social_key])
      social_hash = temp_hash[:social_session]
      user_hash = temp_hash[:user]
      pages = temp_hash[:pages]

      # Pages validates
      if pages.is_a?(Array) && !pages.empty?
        pages.each do |page|
          # Just create if it doesn't exist
          page_acc = PageAccount.new(page) if PageAccount.where(id_on_social: page[:id_on_social]).take.nil?
          begin
            unless page_acc.save
              return render json: { status: 'error', type: :invalid_attr_value, msg: page_acc.errors.messages.to_json }
            end
          rescue
            return render json: { status: 'error', type: :invalid_attr_value, msg: page_acc.errors.messages.to_json }
          end
        end
      end

      # Session validates
      session_no_page = temp_hash.except(:pages)[:social_session]
      # Just create if it doesn't exist
      social_session = SocialSession.new(session_no_page) if SocialSession.where(id_on_social: social_hash[:id_on_social]).take.nil?
      unless social_session.save
        return render json: { status: 'error', type: :invalid_attr_value, msg: social_session.errors.messages.to_json }
      end
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

        # Persist SocialSession & Pages
        if is_social_login
          social_session = SocialSession.where(social_hash).first_or_create
          # Persist per page
          pages.each do |page|
            current_page = PageAccount.new(page)
            current_page.social_sessions << social_session
            current_page.save
          end
        end

        # Prepair the response
        response = { status: 'ok', msg: 'registered' }

        # Manage the Token
        API::Concerns::TokenManager.new(user.email, user.password, params[:access_token])
      else
        response =  { status: 'error', type: :invalid_attr_value, msg: user.errors.messages.to_json }
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