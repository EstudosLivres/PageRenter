json.array!(@accesses) do |access|
  json.extract! access, :id, :converted, :remote_id, :social_network_id, :profile_id, :ad_id
  json.url access_url(access, format: :json)
end
