class PageAccount < ActiveRecord::Base
  # Relations
  has_and_belongs_to_many :social_sessions

  # Attrs Validations
  validates :id_on_social, presence: true, length: { in: 3..45 }, on: [:create, :update]
  validates :name, presence: true, length: { in: 3..75 }, on: [:create, :update]
  validates :category, presence: true, length: { in: 3..25 }, on: [:create, :update]
  validates :followers, presence: true, on: [:create, :update]
  validates :local_interactions, presence: true, on: [:create, :update]
  validates :local_interaction_id, presence: true, on: [:create, :update]
  validates :foreign_interactions, presence: true, on: [:create, :update]
  validates :foreign_interaction_id, presence: true, on: [:create, :update]

  # Validates Associations

  # Return the page session picture
  def get_picture(type='square')
    if self.social_sessions.first.social_network.username == 'facebook'
      return "http://graph.facebook.com/#{self.id_on_social}/picture?type=#{type}"
    end
  end
end