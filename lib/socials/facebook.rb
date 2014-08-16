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
      user_hash[:friend_count] = Fql.execute("SELECT friend_count FROM user WHERE uid=#{user_hash[:id]}").first()['friend_count']
      user_id = user_hash[:id]
      user_greater_interactions = source_interactions_counter user_id

      user_hash[:local_interactions] = user_greater_interactions[:likes][:count]
      user_hash[:local_interaction_id] = user_greater_interactions[:likes][:id]
      user_hash[:foreign_interactions] = user_greater_interactions[:shares][:count]
      user_hash[:foreign_interaction_id] = user_greater_interactions[:shares][:id]

      # setup pages
      user_hash[:pages] = []
      pages = @graph.get_object("me/accounts")
      pages.each do |page|
        page_id = page['id']
        followers = page_followers page_id
        page_greater_interactions = source_interactions_counter page_id

        page[:followers] = followers['likes']
        page[:local_interactions] = page_greater_interactions[:likes][:count]
        page[:local_interaction_id] = page_greater_interactions[:likes][:id]
        page[:foreign_interactions] = page_greater_interactions[:shares][:count]
        page[:foreign_interaction_id] = page_greater_interactions[:shares][:id]
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

    # TODO: pensar em uma tela para ficar mostrando pro usuário enquanto os dados são puxados do facebook (tá demorando em média 30 segs)

    # A GREAT option to get the user LIKEs & SHARE
    def source_interactions_counter(source_id)
      # Summary able say total count (it is called to likes, shares don't need it)
      url = "https://graph.facebook.com/#{source_id}/posts?fields=shares,likes.summary(true)&limit=250&access_token=#{@access_token}"
      posts = JSON.parse(Net::HTTP.get(URI.parse(url)))['data']
      initial_counter = {id:'',count:0}
      greater = {likes:initial_counter, shares:initial_counter}

      # Let's find the best share & best like
      posts.each do |post|
        post_likes = post['likes']
        post_shares = post['shares']

        unless post_likes.nil?
          likes_count = post_likes['summary']['total_count']
          likes_id = get_post_id_on(post['id'], source_id)

          if likes_count > greater[:likes][:count]
            greater[:likes][:id] = likes_id
            greater[:likes][:count] = likes_count
          end
        end

        unless post_shares.nil?
          shares_count = post_shares['count']
          shares_id = get_post_id_on(post['id'], source_id)

          if shares_count > greater[:shares][:count]
            greater[:shares][:id] = shares_id
            greater[:shares][:count] = shares_count
          end
        end
      end

      greater[:likes] = initial_counter if greater[:likes].nil?
      greater[:shares] = initial_counter if greater[:shares].nil?
      return greater
    end

    # Get the Page best liked post
    def page_likes(source_id)
      query =
          "
            SELECT post_id, likes.count
            FROM stream
            WHERE source_id = '#{source_id}'
            AND is_hidden != 'true'
            ORDER BY likes.count
            DESC LIMIT 1
          "
      Fql.execute(query, {access_token:@access_token}).first
    end

    # Get the Page best shared post
    def page_shares(source_id)
      query =
          "
            SELECT post_id, share_count
            FROM stream
            WHERE source_id = '#{source_id}'
            AND is_hidden != 'true'
            ORDER BY share_count
            DESC LIMIT 1
          "
      Fql.execute(query, {access_token:@access_token}).first
    end

    # Get the Page followers
    def page_followers(source_id)
      url = "https://graph.facebook.com/#{source_id}?access_token=#{@access_token}"
      return JSON.parse(Net::HTTP.get(URI.parse(url)))
    end

    # Get the User best liked post
    def user_likes(source_id)
      query =
          "
            SELECT post_id, likes.count
            FROM stream
            WHERE source_id = '#{source_id}'
            AND actor_id = '#{source_id}'
            AND is_hidden != 'true'
            ORDER BY likes.count DESC
            LIMIT 100
          "
      Fql.execute(query, {access_token:@access_token}).first
    end

    # Get the User best shared post
    def user_shares(source_id)
      url = "https://graph.facebook.com/#{source_id}/posts?fields=shares&limit=250&access_token=#{@access_token}"
      posts = JSON.parse(Net::HTTP.get(URI.parse(url)))
      greater_share = {id:'', count:0}

      # Let's find the best share post
      posts.each do |post|
        post_count = post['shares']['count']
        if post_count > greater_share[:count]
          greater_share[:count] = post_count
          greater_share[:id] = post['id']
        end
      end

      return greater_share
    end

    # Strip post_id from id came from Facebook
    def get_post_id_on(facebook_id, source_id)
      return facebook_id["#{source_id}".length+1..facebook_id.length-1]
    end
  end
end