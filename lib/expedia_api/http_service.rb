module ExpediaApi
  module HTTPService

    API_SERVER = 'ews.expedia.com'
    API_PATH   = 'wsapi/rest/hotel/v1/search'

    class << self


      # The address of the appropriate Expedia server.
      #
      # return a complete server address with protocol
      def server(options = {})
        "https://#{API_SERVER}"
      end


      def perform_request(request_options: {}, parameters: {})
        args = common_parameters.merge(parameters)
        # figure out our options for this request
        # set up our Faraday connection
        connection = Faraday.new(:url => server) do |faraday|
          faraday.adapter  Faraday.default_adapter
          faraday.request :json
          faraday.response :json
        end
        connection.post do |req|
          req.url API_PATH
          req.headers['Content-Type'] = 'application/json'
          req.body = args.to_json
        end
      end



      # Common Parameters required for every Call to Expedia Server.
      def common_parameters
        {
          :format       => :json,
          :key          => ExpediaApi.api_key
        }
      end

    end

  end
end
