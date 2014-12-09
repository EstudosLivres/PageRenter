module AdsHelper
  def shorter_url domain, publisher_username, ad_username
    # SetUp the base vars
    shorter_api_url = "https://www.googleapis.com/urlshortener/v1/url"
    path = "#{publisher_username}/#{ad_username}"
    domain = domain+'/' if domain.last != '/'
    domain = "#{domain}accesses/" if domain.index('accesses').nil?

    # Build the link to be shortened & shorter it to return it shortened
    url = "#{domain}#{path}"
    RestClient.post shorter_api_url, {'longUrl'=>url}.to_json, content_type: :json
  end
end
