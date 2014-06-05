class PageAccount < ActiveRecord::Base
  # Relations
  has_and_belongs_to_many :social_sessions

  # Attrs Validations
  validates :id_on_social, presence: true, length: { in: 3..45 }, on: [:create, :update]
  validates :name, presence: true, length: { in: 3..75 }, on: [:create, :update]
  validates :category, presence: true, length: { in: 3..25 }, on: [:create, :update]


  # Validates Associations
end