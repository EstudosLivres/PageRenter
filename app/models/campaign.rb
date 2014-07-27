class Campaign < ActiveRecord::Base
  # Relations
  has_many :ads
  has_many :budgets
  belongs_to :user
  belongs_to :advertiser, class_name: 'Profile', foreign_key: :advertiser_id

  # Rails validations
  validates :name, presence: true, length: { in: 5..75 }, on: [:create, :update]
  validates :launch_date, presence: true, on: [:create, :update]
  validates :end_date, presence: true, on: [:create, :update]
end
