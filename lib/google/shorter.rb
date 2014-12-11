require 'google/google'
class Google::Shorter
  # Generate it shorter URL based ont he LongURL passed
  def self.generate url
    resp = RestClient.post Google.shorter_api_url, {'longUrl'=>url}.to_json, content_type: :json
    JSON.parse(resp).symbolize_keys
  end
end
