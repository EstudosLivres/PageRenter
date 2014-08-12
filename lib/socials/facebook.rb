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
      @graph.get_object("me")
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
      @access_token = @oauth.get_access_token(code)
      @graph = Koala::Facebook::API.new(@access_token)
      return @access_token
    end
  end
end