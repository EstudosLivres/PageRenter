class Role < ActiveRecord::Base
  # Relations
  has_many :profiles

end
