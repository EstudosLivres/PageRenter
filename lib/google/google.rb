# Module Google define constants, like REST URLs
module Google
  # Google REST ShorterAPIURL
  @@shorter_api_url = "https://www.googleapis.com/urlshortener/v1/url"

  # Return the SHORTER REST URL for Goo.GL
  def self.shorter_api_url
    @@shorter_api_url
  end
end