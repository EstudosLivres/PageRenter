
  # Create an user_hash (instanciable) from a social_hash RETURNS: [:user] & [:social_session]
  def self.new_social_user social_hash
    user = social_hash['login']
    pages = social_hash['pages']['data']

    hash_return = {:user => {}, :social_session => {}}

    hash_return[:user] = {name: user['name'], username: user['username'], email: user['email'], locale: user['locale'], 'role' => 'publisher'}
    hash_return[:social_session] = {id_on_social: user['id'], name: user['name'], username: user['username'], email: user['email'], gender: user['gender'], locale: user['locale'], gender: user['gender'], count_friends: user['count_friends'], social_network_id: user['network_id']}
    hash_return[:pages] = []

    # Append the pages
    pages.each do |page|
      page = page[1] if page.is_a?Array
      hash_return[:pages].append({ id_on_social: page['id'], name: page['name'], category: page['category'], access_token: page['access_token'] })
    end

    hash_return
  end

  # Persist the user
  def self.convert_into_social_user_hash_the
    # user_hash depends if it was by form or by Social Login (input_hash.has_key?(social_key)=true ->SocialLogin else Form)
    social_key = 'social_session'
    is_social_login = input_hash.has_key?(social_key)
    if is_social_login
      temp_hash = User.create_user_hash_from_social(input_hash[social_key])
      social_hash = temp_hash[:social_session]
      user_hash = temp_hash[:user]
      pages = temp_hash[:pages]

      # Session validates
      session_no_page = temp_hash.except(:pages)[:social_session]
      # Just create if it doesn't exist
      social_session = SocialSession.new(session_no_page) if SocialSession.where(id_on_social: social_hash[:id_on_social]).take.nil?
      social_session[:pages] = pages
    else user_hash = input_hash end

    user_hash[:social_session] = social_session
    return user_hash
  end