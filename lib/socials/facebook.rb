module Socials
  class Facebook < SocialLib
    attr_accessor :access_token
    attr_accessor :graph

    # Config the app for the connection
    def setup()
      app_id = Rails.application.secrets.fb.app_id
      app_secret = Rails.application.secrets.fb.app_secret
      app_redirect = Rails.application.secrets.fb.redir_url
      @access_token = Koala::Facebook::OAuth.new(app_id, app_secret, app_redirect)
      @graph = Koala::Facebook::API.new
    end

    # Redirect the user to the SocialNetwork SignUp page
    def sign_up(sign_up_hash) end

    # Get the user Logged hash & accesses (OAuth)
    def get_current_user()
      @graph.get_object("koppel")
    end

    # Get the Multi logins from the user (Pages, in Facebook case)
    def get_user_admin_logins() end

    # Retrieve the user accepted permissions on the SocialNetwork
    def get_active_permission() end

    # Share in Facebook OR tweet on Twitter
    def send_msg(msg, link) end

    # The current user avatar link
    def get_user_avatar() end
  end
end