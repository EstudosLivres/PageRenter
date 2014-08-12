module Socials
  class Twitter < SocialLib
    # Config the app for the connection
    def self.setup(setup_hash) end
    # Redirect the user to the SocialNetwork SignUp page
    def self.sign_up(sign_up_hash) end
    # Get the user Logged hash & accesses (OAuth)
    def self.get_current_user() end
    # Get the Multi logins from the user (Pages, in Facebook case)
    def self.get_user_admin_logins() end
    # Retrieve the user accepted permissions on the SocialNetwork
    def self.get_active_permission() end
    # Share in Facebook OR tweet on Twitter
    def self.send_msg(msg, link) end
  end
end