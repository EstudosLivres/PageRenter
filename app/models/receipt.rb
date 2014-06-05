class Receipt < ActiveRecord::Base
  belongs_to :transaction
end
