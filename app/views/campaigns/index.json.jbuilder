json.array!(@campaigns) do |campaign|
  json.extract! campaign, :id, :name, :redirect_link, :slogan, :description, :social_phrase
  json.url campaign_url(campaign, format: :json)
end
