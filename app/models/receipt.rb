class Receipt < ActiveRecord::Base
  belongs_to :transaction

  validates :token, presence: true, length: { in: 3..50 }, on: create
  validates :id_on_operator, presence: true, length: { in: 3..45 }, on: create
  validates :url_access, presence: true, length: { in: 15..45 }, on: create
  validates :transaction_id, presence: true, on: create
end
