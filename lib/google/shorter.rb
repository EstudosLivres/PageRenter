require 'google/google'

module Google
  class Shorter
    # Generate it shorter URL based ont he LongURL passed
    def self.generate url
      api_url = Google.shorter_url
      resp = RestClient.post api_url, {'longUrl'=>url}.to_json, content_type: 'application/json'
      JSON.parse(resp).symbolize_keys[:id]
    end
  end
end