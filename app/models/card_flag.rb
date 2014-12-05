class CardFlag < ActiveRecord::Base
  # Associations
  has_many :budgets

  # Rails validations
  validates :name, presence: true, length: { in: 3..30 }, on: [:create, :update]
  validates :acronym, presence: true, length: { in: 3..30 }, on: [:create, :update]
end
