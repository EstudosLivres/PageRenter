class Campaign < ActiveRecord::Base
  # Relations
  belongs_to :user
  has_attached_file :advertising_piece, :styles => { :medium => '470x300>', :thumb => '117x75>' }, :default_url => '/images/:style/missing.png'

  # Rails validations
  validates :name, presence: true, length: { in: 3..50 }, on: [:create, :update]
  validates :redirect_link, presence: true, length: { in: 15..200 }, on: [:create, :update]
  validates :slogan, presence: false # Slogan is not required
  validates :description, presence: true, length: { in: 5..140 }
  validates :social_phrase, presence: false # Social phrase is not required
  validates :user_id, presence: true
  validates_attachment_content_type :advertising_piece, :content_type => /\Aimage\/.*\Z/
end
