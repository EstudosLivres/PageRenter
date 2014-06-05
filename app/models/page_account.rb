class PageAccount < ActiveRecord::Base
  # Relations
  has_and_belongs_to_many :social_sessions

  # Validates Associations
end