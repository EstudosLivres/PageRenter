class Segment < ActiveRecord::Base
  # Relations
  has_and_belongs_to_many :ads
end
