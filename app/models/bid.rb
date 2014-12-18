class Bid < ActiveRecord::Base
  # Relations
  belongs_to :ad
  belongs_to :currency

  # Custom validations
  before_validation :disable_last_bid, on: [:create]

  # Rails validations TODO: validate the min paid
  # The *100 means the cents. The 1*100 is a R$/US$ 1,00, to only 1 cents it need to be 0.01*100
  validates :per_local_interaction, presence: true, format: { :with => /\A\d+(?:\.\d{0,2})?\z/ }, numericality: {greater_than: 0.02*100}, on: [:create, :update]
  validates :per_foreign_interaction, presence: true, format: { :with => /\A\d+(?:\.\d{0,2})?\z/ }, numericality: {greater_than: 0.04*100}, on: [:create, :update]
  validates :per_visitation, presence: true, format: { :with => /\A\d+(?:\.\d{0,2})?\z/ }, numericality: {greater_than: 0.50*100}, on: [:create, :update]
  validates :per_conversion, presence: true, format: { :with => /\A\d+(?:\.\d{0,2})?\z/ }, numericality: {greater_than: 5.00*100}, on: [:create, :update]

  # Validates Associations
  validates :ad_id, presence: true, on: [:create, :update]
  validates :currency_id, presence: true, on: [:create, :update]

  # Method to print the values on the masked form, based on which method to call
  # TODO Bid must have the same logic of the budget, check if it really works
  def operator_value_str attr_symbol
    return real_value(attr_symbol) if Rents::Currency.have_cents? real_value(attr_symbol) if real_value(attr_symbol)
    real_value(attr_symbol)*10 if real_value(attr_symbol) # it is to convert the int float, like 1.0 to 1.00
  end

  # DesignPattern, if there is a place where it must be print & is possible to have no relation, call the safe
  def safe_currency
    self.currency.nil? ? Currency.new : self.currency
  end

  # ActiveRecord Get Method overwrite to print the real value, not the operator value
  def real_value attr_symbol
    read_attribute(attr_symbol).to_f/100 if read_attribute(attr_symbol)
  end

  # Return currency full name if there is a currency associated
  def it_currency
    currency.nil? ? nil : currency.acronym_with_name
  end

  # =============================== Callbacks ============================
  private
    # The bid cannot be UPDATED, always save a new one
    def disable_last_bid
      # Only on the creation it receive active as true
      self.active = true if self.id.nil?
      last_bid = self.ad.bids.last
      unless last_bid.nil?
        begin
          last_bid.update(active:false, closed_date:"#{Time.now()}")
        rescue => e
          self.errors.messages.add(e.message)
        end
      end
    end
end
