class Google::Shorter
  # URL for the Google Shorter API
  @@shorter_api_key = '?key=AIzaSyCJOefXdhTtFIX9Y-G2IAFNJrAlZ2PkQhg'
  @@shorter_api_url = "https://www.googleapis.com/urlshortener/v1/url"

  # Generate it shorter URL based ont he LongURL passed
  def self.generate url
    api_url = @@shorter_api_url + @@shorter_api_key
    resp = RestClient.post api_url, {'longUrl'=>url}.to_json, content_type: :json
    JSON.parse(resp).symbolize_keys()[:id]
  end
end
