module ExpediaApi
  module HTTPService

    API_SERVER = 'ews.expedia.com'

    class << self


      # The address of the appropriate Expedia server.
      #
      # return a complete server address with protocol
      def server_url
        "http://#{API_SERVER}"
      end

      def faraday_options
        options = {
          url: server_url
        }
        if use_proxy?
          options[:proxy] = proxy_options
        end
        options
      end

      def perform_request(request_options: {}, parameters: {}, uri:)
        args = common_parameters.merge(parameters)
        # figure out our options for this request
        # set up our Faraday connection
        connection = Faraday.new(faraday_options) do |faraday|
          faraday.adapter  Faraday.default_adapter
        end
        connection.get(uri, args)
      end

      def use_proxy?
        !!(ExpediaApi.proxy_uri && ExpediaApi.proxy_user && ExpediaApi.proxy_password)
      end

      def proxy_options
        {
          uri: ExpediaApi.proxy_uri,
          user: ExpediaApi.proxy_user,
          password: ExpediaApi.proxy_password
        }
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
