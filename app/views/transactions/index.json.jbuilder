json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :value, :currency, :banking, :payment_method_id, :payer_id, :receiver_id
  json.url transaction_url(transaction, format: :json)
end
