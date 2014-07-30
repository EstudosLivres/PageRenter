class Currency < ActiveRecord::Base
  has_many :ad_pricings
  has_many :financial_transactions

  # Aux methods to return better understandable
  def acronym_with_name
    name = I18n.t("db_enum.currencies.#{self.name}")
    "#{self.acronym} - #{name}"
  end
end
