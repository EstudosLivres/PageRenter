class Budget < ActiveRecord::Base
  belongs_to :currency
  belongs_to :campaign
  belongs_to :recurrence_period

  # Custom validations

  # Rails validations
  validates :activated, presence: true, on: [:create, :update]
  validates :value, presence: true, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than => 1, :less_than => 100000000}, on: [:create, :update]
  validates :closed_date, presence: true, on: :update

  # Validates Associations
  validates :currency_id, presence: true, on: [:create, :update]
  validates :campaign_id, presence: true, on: [:create, :update]
  validates :recurrence_period_id, presence: true, on: [:create, :update]

  # TODO activated significa que é o orçamento corrente este que o usuário está usando
  # TODO lembrar que os orçamentos nunca são editados, sempre são criados novos
end
