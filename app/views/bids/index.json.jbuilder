json.array!(@bids) do |bid|
  json.extract! bid, :id, :visitation, :impression, :foreign_interactions, :local_interactions, :campaign_id, :currency_id
  json.url bid_url(bid, format: :json)
end
