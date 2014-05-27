class Profile < ActiveRecord::Base
  # Relations
  belongs_to :user
  belongs_to :role

  # Constants
  enum role_name: { publisher: 1, advertiser: 2, admin: 3 }

  def self.get_default_role profiles
    profiles.each do |profile|
      if profile.default_role then return profile.role.name end
    end
  end

  # diferent GetName
  def name
    if(!self.name.nil? && self.name.length >= 1) then return self.name else return self.user.name end
  end
end
