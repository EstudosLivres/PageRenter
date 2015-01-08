module Google
  # URL for the Google Shorter API
  @google_credentials = Rails.application.secrets.google.symbolize_keys
  #@google_credentials_web = @google_credentials[:web]
  #@google_credentials_server = @google_credentials[:server]
  @shorter_api_key = "?key=#{@google_credentials[:global_key]}"
  @shorter_api_url = "https://www.googleapis.com/urlshortener/v1/url"

  def self.shorter_url
    @shorter_api_url + @shorter_api_key
  end
end