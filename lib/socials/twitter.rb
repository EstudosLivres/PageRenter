module Socials
  class Twitter < SocialLib
    # Config the app for the connection
    def setup()
      puts 'SetUp TWITTER!'
    end

    # Redirect the user to the SocialNetwork SignUp page
    def sign_up(sign_up_hash) end
    # Get the user Logged hash & accesses (OAuth)
    def get_current_user() end
    # Get the Multi logins from the user (Pages, in Facebook case)
    def get_user_admin_logins() end
    # Retrieve the user accepted permissions on the SocialNetwork
    def get_active_permission() end
    # Share in Facebook OR tweet on Twitter
    def send_msg(msg, link) end
    # Post on the social
    def post(message, link, img) end
  end
end