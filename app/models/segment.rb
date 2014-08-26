class Segment < ActiveRecord::Base
  # Relations
  has_and_belongs_to_many :ads
  has_and_belongs_to_many :social_session_segments

  # Rails validations
  validates :name, presence: true, length: { in: 10..140 }, on: [:create, :update]
  validates :description, presence: false, on: [:create, :update]

  # SetUp the List of users
  def setup_uids uids
    uids = uids.split unless uids.is_a?(Array) || uids.is_a?(Hash)

    # Persist the UIDs
    uids.each do |uid|
      social_segment = SocialSessionSegment.new({id_on_social:uid})
      self.social_session_segments << social_segment
    end
  end
end
