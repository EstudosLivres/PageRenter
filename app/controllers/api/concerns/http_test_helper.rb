module API::Concerns
  class HttpTestHelper
    extend ActiveSupport::Concern

    def initialize url=nil
      if url.nil? then @url = 'http://localhost:4000/api' else @url = url end
    end

    def post(path, hash_params)
      uri = URI.parse(@url+path)
      return Net::HTTP.post_form(uri, hash_params)
    end

    def get(path, hash_params)

    end
  end
end