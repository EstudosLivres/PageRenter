class Currency < ActiveRecord::Base
  # Associations
  has_many :bids
  has_many :financial_transactions

  # Aux methods to return better understandable
  def acronym_with_name
    name = I18n.t("db_enum.currencies.#{self.name}")
    "#{self.acronym} - #{name}"
  end

  # Receive it amount in Decimal and convert to operator str, like 10,00 to 1000
  # * To use it remember to remove '.' and ',' from the controller params entries
  def self.to_operator_str amount
    # Check invalid entries
    return nil if amount.nil?

    # Logical for DecimalAmount
    amount_str = amount.to_s
    the_dot_char = 1
    dot_index = amount_str.index('.')
    return amount_str[0..dot_index-the_dot_char]
  end

  # Receive it amount in Integer String and convert to Decimal value
  def self.decimal_from_operator_str amount
    # Base vars
    aux_amount = amount
    cents_chars_counter = 2

    # Building the currency str like BigDecimal understands
    cents_str = aux_amount[aux_amount.length-cents_chars_counter..aux_amount.length]
    currency_integer_str = aux_amount[0, aux_amount.length-cents_chars_counter]
    new_amount = "#{currency_integer_str}.#{cents_str}"

    BigDecimal.new new_amount
  end
end
