class Currency < ActiveRecord::Base
  # Associations
  has_many :bids
  has_many :financial_transactions

  # Aux methods to return better understandable
  def acronym_with_name
    name = I18n.t("db_enum.currencies.#{self.name}")
    "#{self.acronym} - #{name}"
  end

  # Receive it amount in any mask formatted (like: 1.000,00 or 1,000.00) Return the amount as operator need to be in string
  def self.to_operator_str amount
    # aux var to be more readable
    decimal_cents = 2
    unit_cents = 1
    amount_length_index = amount.length
    decimal_cents_index = amount_length_index-decimal_cents
    unit_cents_index = amount_length_index-unit_cents

    # aux vars to manipulate the return result
    amount_cents = amount[decimal_cents_index, unit_cents_index]
    raise   unless amount_cents.first.is_integer? || amount_cents.last.is_integer?
    amount_without_cents = amount[0, decimal_cents_index]
    amount_striped = amount_without_cents.remove('.').remove(',')

    # Build the value as the operator understand, and return it
    "#{amount_striped}#{amount_cents}"
  end
end
