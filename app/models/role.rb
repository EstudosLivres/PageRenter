class Role < ActiveRecord::Base
  # Relations
  has_many :user_account_per_roles
  has_many :users, through: :user_account_per_roles

end
