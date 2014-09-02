class SocialNetwork < ActiveRecord::Base
  # Relations
  has_many :social_sessions

  # Attrs validations
  validates :name, presence: true, length: { in: 3..50 }, on: [:create, :update]
  validates :acronym, length: { in: 2..10 }, on: [:create, :update]
  validates :username, length: { in: 2..25 }, on: [:create, :update]

  # Validates Associations

  # Get the social session, from it social network from user passed
  def get_social_session(user)
    self.social_sessions.where(user_id: user.id).take
  end

  # ----- STATICs AUX METHODs -----

  def self.persist_social_user(network_obj)
    # Get the class (name after the module => 'module::class')
    obj_instance = /[^::]*$/.match("#{network_obj.class}")
    obj_instance_str = "#{obj_instance}".downcase

    # About the authentication (to prevent to retrieve all data from the user again)
    base_user_hash = network_obj.get_base_user
    # Authenticate the user TODO: is it wrong? if if using OAuth should I remove the validation on SocialSession which was for JS or wait need it on JS?
    sn = SocialNetwork.where(username:obj_instance_str).take
    user = User.joins(:social_sessions).where('social_sessions.email'=>base_user_hash[:email],'social_sessions.social_network_id'=>sn.id).take
    return user unless user.nil?

    # Retrieving the user data
    social_obj = network_obj.get_current_user
    social_obj[:access_token] = network_obj.access_token
    social_obj[:social_network] = obj_instance_str

    # User already registered, do not persist it (PREVENT)
    authenticated = SocialSession.authenticate(social_obj)
    return authenticated if authenticated.is_a?(User)

    social_hash = self.send("create_from_#{obj_instance_str}", social_obj)

    # Persist the user, just continue if user have been saved
    if social_hash[:user].save
      social_hash[:social_session].user = social_hash[:user]

      # Persist the pages & associate it to the session
      social_hash[:pages].each do |page|
        if page.save
          social_hash[:social_session].page_accounts << page
        else
          return page
        end
      end

      if social_hash[:social_session].save
        social_hash[:user].social_sessions << social_hash[:social_session]
      else
        return social_hash[:social_session]
      end
    else
      return social_hash[:user]
    end

    return social_hash[:user]
  end

  def self.create_from_facebook(social_obj)
    return_hash = {}
    user_hash = {
      role:'publisher',
      name:social_obj[:name],
      username:social_obj[:username],
      email:social_obj[:email],
      locale:social_obj[:locale]
    }

    social_hash = {
      id_on_social:social_obj[:id],
      name:social_obj[:name],
      username:social_obj[:username],
      email:social_obj[:email],
      gender:social_obj[:gender],
      locale:social_obj[:locale],
      access_token:social_obj[:access_token],
      friend_count:social_obj[:friend_count],
      local_interactions:social_obj[:local_interactions],
      local_interaction_id:social_obj[:local_interaction_id],
      foreign_interactions:social_obj[:foreign_interactions],
      foreign_interaction_id:social_obj[:foreign_interaction_id],
      social_network_id: SocialNetwork.where(name:'Facebook').take.id
    }

    pages = []
    social_obj[:pages].each do |page|
      pages.append(PageAccount.new({
        id_on_social:page['id'],
        name:page['name'],
        category:page['category'],
        followers:page[:followers],
        local_interactions:page[:local_interactions],
        local_interaction_id:page[:local_interaction_id],
        foreign_interactions:page[:foreign_interactions],
        foreign_interaction_id:page[:foreign_interaction_id]
      }))
    end

    # user
    return_hash[:user] = User.new_user_with_it_role(user_hash)

    # social
    return_hash[:social_session] = SocialSession.new(social_hash)

    #pages
    return_hash[:pages] = pages

    return return_hash
  end

  def self.create_from_twitter(social_obj)
    return_hash = {}
    return_hash[:user] = User.new({name:'',username:'',email:'',locale:''})
    return_hash[:social_session] = SocialSession.new({id_on_social:'',name:'',username:'',email:'',gender:'',locale:'',count_friends:''})
    return_hash[:pages] = PageAccount.new({id_on_social:'',name:'',category:''})

    return return_hash
  end
end
