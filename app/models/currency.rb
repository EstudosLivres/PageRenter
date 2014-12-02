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
end
