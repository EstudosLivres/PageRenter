json.array!(@banned_ad_histories) do |banned_ad_history|
  json.extract! banned_ad_history, :id, :reason, :description, :user_id, :ad_id
  json.url banned_ad_history_url(banned_ad_history, format: :json)
end
