class AdState < ActiveRecord::Base
  # Relations
  has_many :ad_history_states
  has_many :ads, through: :ad_history_states

  # Rails validations
  validates_uniqueness_of :name
  validates :name, presence: true, length: { in: 3..40 }, on: [:create, :update]
  validates :msg, presence: true, length: { in: 3..40 }, on: [:create, :update]
end
