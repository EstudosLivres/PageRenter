class PageAccount < ActiveRecord::Base
  # Relations
  has_and_belongs_to_many :social_sessions

  # Attrs Validations
  validates :id_on_social, presence: true, length: { in: 1..45 }, on: [:create, :update]
  validates :name, presence: true, length: { in: 3..75 }, on: [:create, :update]

  # Non mandatory attrs
  validates :category, presence: false, on: [:create]
  validates :category, length: { in: 3..25 }, on: [:update]
  validates :followers_counter, numericality: { only_integer: true, greater_than: 0 }, presence: false, on: [:create, :update]
  validates :local_interactions, numericality: { only_integer: true, greater_than: 0 }, presence: false, on: [:create, :update]
  validates :local_interaction_id, presence: false, on: [:create, :update]
  validates :local_interaction_id, length: { in: 3..55 }, on: [:update]
  validates :foreign_interactions, numericality: { only_integer: true, greater_than: 0 }, presence: false, on: [:create, :update]
  validates :foreign_interaction_id, presence: false, on: [:create, :update]
  validates :foreign_interaction_id, length: { in: 3..55 }, on: [:update]

  # Validates Associations

  # Return the page session picture
  def get_picture(type='square')
    if self.social_sessions.first.social_network.username == 'facebook'
      return "http://graph.facebook.com/#{self.id_on_social}/picture?type=#{type}"
    end
  end
end