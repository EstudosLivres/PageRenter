class Profile < ActiveRecord::Base
  # Relations
  belongs_to :user
  belongs_to :role

end
