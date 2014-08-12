module Socials
  class Facebook < SocialLib
    attr_accessor :access_token

    # Config the app for the connection
    def setup()
      app_id = Rails.application.secrets.fb_app_id
      app_secret = Rails.application.secrets.fb_app_secret
      @access_token = Koala::Facebook::OAuth.new(app_id, app_secret).get_app_access_token
    end

    # Redirect the user to the SocialNetwork SignUp page
    def sign_up(sign_up_hash) end

    # Get the user Logged hash & accesses (OAuth)
    def get_current_user()

    end

    # Get the Multi logins from the user (Pages, in Facebook case)
    def get_user_admin_logins() end

    # Retrieve the user accepted permissions on the SocialNetwork
    def get_active_permission() end

    # Share in Facebook OR tweet on Twitter
    def send_msg(msg, link) end
  end
end