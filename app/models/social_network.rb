class SocialNetwork < ActiveRecord::Base
  # Relations
  has_many :social_sessions

  # Attrs validations
  validates :name, presence: true, length: { in: 3..50 }, on: [:create, :update]
  validates :acronym, length: { in: 2..10 }, on: [:create, :update]
  validates :username, length: { in: 2..25 }, on: [:create, :update]

  # Validates Associations

  # ----- STATICs AUX METHODs -----

  def self.persist_social_user(network_obj)
    # Get the class (name after the module => 'module::class')
    obj_instance = /[^::]*$/.match("#{network_obj.class}")
    obj_instance_str = "#{obj_instance}".downcase
    social_obj = network_obj.get_current_user
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
      friend_count:social_obj[:friend_count],
      social_network_id: SocialNetwork.where(name:'Facebook').take.id
    }

    pages = []
    social_obj[:pages].each do |page|
      pages.append(PageAccount.new({
        id_on_social:page['id'],
        name:page['name'],
        category:page['category'],
        access_token:page['access_token']
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
    return_hash[:pages] = PageAccount.new({id_on_social:'',name:'',category:'',access_token:''})

    return return_hash
  end
end
