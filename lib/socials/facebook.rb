module Socials
  class Facebook < SocialLib
    attr_accessor :access_token
    attr_accessor :graph
    attr_accessor :fb_config

    # Config the app for the connection
    def setup
      # load fb_config
      @fb_config = RailsFixes::Util.hash_keys_to_sym(Rails.application.secrets.facebook)
      
      # Using fb_config (not Rails.app.secrets direct)
      app_id = @fb_config[:app_id]
      app_secret = @fb_config[:app_secret]
      app_redirect = @fb_config[:redir_url]
      @oauth = Koala::Facebook::OAuth.new(app_id, app_secret, app_redirect)
    end

    # Redirect the user to the SocialNetwork SignUp page
    def sign_up
      @oauth.url_for_oauth_code(permissions:@fb_config[:app_permissions])
    end

    # Get the user Logged hash & accesses (OAuth)
    def get_current_user
      user_hash = RailsFixes::Util.hash_keys_to_sym(@graph.get_object("me"))
      user_hash[:friend_count] = Fql.execute("SELECT friend_count FROM user WHERE uid=#{user_hash[:id]}")[0]['friend_count']

      # setup pages
      user_hash[:pages] = []
      pages = @graph.get_object("me/accounts")
      pages.each do |page|
        page_id = page['id']
        local_interactions = get_likes(page_id)
        foreign_interactions = get_shares(page_id)
        followers = get_followers(page_id)
        local_interactions = {'likes'=>{'count'=>0}, 'post_id'=>0} if local_interactions.nil?
        foreign_interactions = {'share_count'=>0, 'post_id'=>0} if foreign_interactions.nil?

        page[:followers] = followers['likes']
        page[:local_interactions] = local_interactions['likes']['count']
        page[:local_interaction_id] = local_interactions['post_id']
        page[:foreign_interactions] = foreign_interactions['share_count']
        page[:foreign_interaction_id] = foreign_interactions['post_id']
        user_hash[:pages].append(page)
      end

      return user_hash
    end

    # Get the Multi logins from the user (Pages, in Facebook case)
    def get_user_admin_logins() end

    # Retrieve the user accepted permissions on the SocialNetwork
    def get_active_permission() end

    # Share in Facebook OR tweet on Twitter
    def send_msg(msg, link) end

    # The current user avatar link
    def get_user_avatar() end

    # Setup the Graph
    def set_up_graph(code)
      begin
        @access_token = @oauth.get_access_token(code)
        @graph = Koala::Facebook::API.new(@access_token)
        return @access_token
      rescue
        return sign_up
      end
    end

    # Get the Page or User best liked post
    def get_likes(source_id)
      query =
          "
            SELECT post_id, likes.count
            FROM stream
            WHERE source_id = '#{source_id}'
            ORDER BY likes.count
            DESC LIMIT 1
          "
      Fql.execute(query, {access_token:@access_token}).first
    end

    # Get the Page or User best shared post
    def get_shares(source_id)
      query =
          "
            SELECT post_id, share_count
            FROM stream
            WHERE source_id = '#{source_id}'
            ORDER BY share_count
            DESC LIMIT 1
          "
      Fql.execute(query, {access_token:@access_token}).first
    end

    # Get the Page followers
    def get_followers(source_id)
      url = "https://graph.facebook.com/#{source_id}?access_token=#{@access_token}"
      return JSON.parse(Net::HTTP.get(URI.parse(url)))
    end
  end
end