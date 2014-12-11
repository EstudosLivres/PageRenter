class Currency < ActiveRecord::Base
  # Associations
  has_many :bids
  has_many :financial_transactions

  # Aux methods to return better understandable
  def acronym_with_name
    name = I18n.t("db_enum.currencies.#{self.name}")
    return '' if self.acronym.nil? || self.name.nil?
    "#{self.acronym} - #{name}"
  end

  # DesignPattern, if there is a place where it must be print & is possible to have no relation, call the safe
  def safe_acronym
    self.acronym.nil? ? '' : self.acronym
  end
end
