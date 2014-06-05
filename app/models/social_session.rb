class SocialSession < ActiveRecord::Base
  # Relations
  belongs_to :user
  belongs_to :social_network
  has_and_belongs_to_many :page_accounts

  # Rails validations
  validates :id_on_social, presence: true, length: { maximum: 45 }
  validates :name, presence: true, length: { maximum: 65 }
  validates :username, presence: true, length: { maximum: 45 }
  validates :email, presence: true, length: { maximum: 55 }
  validates :gender, presence: false, length: { maximum: 10 }
  validates :locale, presence: true, length: { maximum: 5 }
  validates :count_friends, presence: true

  # Validates Associations
  validates :user_id, presence: true, on: [:create, :update]
  validates :social_network_id, presence: true, on: [:create, :update]
end
