json.array!(@budgets) do |budget|
  json.extract! budget, :id, :active, :value, :closed_date, :currency_id, :campaign_id, :recurrence_period_id
  json.url budget_url(budget, format: :json)
end
