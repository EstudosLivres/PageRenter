class Bid < ActiveRecord::Base
  # Relations
  belongs_to :ad
  belongs_to :currency

  # Custom validations

  # Rails validations TODO: validate the min paid
  validates :per_local_interaction, presence: true, format: { :with => /\A\d+(?:\.\d{0,2})?\z/ }, numericality: {greater_than: 0.01}, on: [:create, :update]
  validates :per_foreign_interaction, presence: true, format: { :with => /\A\d+(?:\.\d{0,2})?\z/ }, numericality: {greater_than: 0.02}, on: [:create, :update]
  validates :per_visitation, presence: true, format: { :with => /\A\d+(?:\.\d{0,2})?\z/ }, numericality: {greater_than: 0.05}, on: [:create, :update]
  validates :per_conversion, presence: true, format: { :with => /\A\d+(?:\.\d{0,2})?\z/ }, numericality: {greater_than: 1.00}, on: [:create, :update]

  # Validates Associations
  validates :ad_id, presence: true, on: [:create, :update]
  validates :currency_id, presence: true, on: [:create, :update]

  # Return currency full name if there is a currency associated
  def it_currency
    currency.nil? ? nil : currency.acronym_with_name
  end
end
