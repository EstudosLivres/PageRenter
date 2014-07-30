class RecurrencePeriod < ActiveRecord::Base
  has_many :budgets

  # Rails validations
  validates :name, presence: true, length: { in: 5..15 }, on: [:create, :update]

  # Aux methods to return better understandable
  def translated_recurrence_name
    I18n.t("db_enum.recurrence_periods.#{self.name}")
  end
end
