class Bid < ActiveRecord::Base
  # Relations
  belongs_to :ad
  belongs_to :currency

  # Custom validations

  # Rails validations TODO: validate the min paid
  # The *100 means the cents. The 1*100 is a R$/US$ 1,00, to only 1 cents it need to be 0.01*100
  validates :per_local_interaction, presence: true, format: { :with => /\A\d+(?:\.\d{0,2})?\z/ }, numericality: {greater_than: 0.01*100}, on: [:create, :update]
  validates :per_foreign_interaction, presence: true, format: { :with => /\A\d+(?:\.\d{0,2})?\z/ }, numericality: {greater_than: 0.02*100}, on: [:create, :update]
  validates :per_visitation, presence: true, format: { :with => /\A\d+(?:\.\d{0,2})?\z/ }, numericality: {greater_than: 0.05*100}, on: [:create, :update]
  validates :per_conversion, presence: true, format: { :with => /\A\d+(?:\.\d{0,2})?\z/ }, numericality: {greater_than: 1.00*100}, on: [:create, :update]

  # Validates Associations
  validates :ad_id, presence: true, on: [:create, :update]
  validates :currency_id, presence: true, on: [:create, :update]

  # Method to print the values on the masked form, based on which method to call
  # TODO Bid must have the same logic of the budget, check if it really works
  def operator_value_str attr_symbol
    return real_value(attr_symbol) if Rents::Currency.have_cents? real_value(attr_symbol) if real_value(attr_symbol)
    real_value(attr_symbol)*10 if real_value(attr_symbol) # it is to convert the int float, like 1.0 to 1.00
  end

  # ActiveRecord Get Method overwrite to print the real value, not the operator value
  def real_value attr_symbol
    read_attribute(attr_symbol).to_f/100 if read_attribute(attr_symbol)
  end


  # Return currency full name if there is a currency associated
  def it_currency
    currency.nil? ? nil : currency.acronym_with_name
  end
end
