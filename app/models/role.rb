class Role < ActiveRecord::Base
  # Relations
  has_many :profiles

  # Validates Associations
end
