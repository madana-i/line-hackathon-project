require 'rest-client'

module Line
  module Bot
    class HTTPClient
      def post(url, payload, header = {})
        binding.pry
        RestClient.proxy = ENV["FIXIE_URL"]
        RestClient.post(url, payload, header)
      end
    end
  end
end
