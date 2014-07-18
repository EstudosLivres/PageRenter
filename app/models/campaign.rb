class Campaign < ActiveRecord::Base
  # Relations
  belongs_to :advertiser, class_name: 'User', foreign_key: :advertiser_id
  has_many :bank_transactions
  has_attached_file :avatar, :styles => { :medium => '470x300>', :thumb => '117x75>' }, :default_url => '/images/:style/missing.png'

  # Rails validations
  validates :name, presence: true, length: { in: 3..50 }, on: [:create, :update]
  validates :redirect_link, presence: true, length: { in: 15..200 }, on: [:create, :update]
  validates :title, presence: true, length: { in: 3..50 }, on: [:create, :update]
  validates :description, presence: true, length: { in: 5..140 }
  validates :social_phrase, presence: false # Social phrase is not required
  validates :advertiser_id, presence: true
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  # Validates Associations
  validates :advertiser_id, presence: true, on: [:create, :update]

=begin
  def update_it
    # current_value_on_bd =
    # current_value_on_memory =
    # if != insert new clickvalue
  end
=end
end
