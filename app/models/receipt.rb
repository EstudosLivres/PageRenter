class Receipt < ActiveRecord::Base
  belongs_to :bank_transaction

  # Attrs validations
  validates :token, presence: true, length: { in: 3..50 }, on: [:create, :update]
  validates :id_on_operator, presence: true, length: { in: 3..45 }, on: [:create, :update]
  validates :url_access, presence: true, length: { in: 15..45 }, on: [:create, :update]
  validates :transaction_id, presence: true, on: [:create, :update]

  # Validates Associations
  validates :transaction_id, presence: true, on: [:create, :update]
end
