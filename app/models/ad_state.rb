class AdState < ActiveRecord::Base
  # Relations
  has_many :ad_history_states
  has_many :ads, through: :ad_history_states

  # Rails validations
  validates :name, presence: true, length: { in: 3..40 }, on: [:create, :update]
end
