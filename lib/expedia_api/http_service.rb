require 'faraday'

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


      # Adding open and read timeouts
      #
      # return the connection obj with the timeouts set if they have been initialized
      def add_timeouts(conn)
        conn.options.timeout = 50
        conn.options.open_timeout = 50
        conn
      end

      def perform_request(request_options: {}, parameters: {})
        args = common_parameters.merge(parameters)
        # figure out our options for this request
        # set up our Faraday connection
        conn = Faraday.new(server)
        conn = add_timeouts(conn)
        response = conn.send(:get, API_PATH, args)
        response
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

