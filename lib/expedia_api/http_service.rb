require 'faraday'

module ExpediaApi
  module HTTPService

    API_SERVER = 'api.eancdn.com'

    class << self


      # The address of the appropriate Expedia server.
      #
      # @param options various flags to indicate which server to use.
      # @option options :reservation_api use the RESERVATION API instead of the REGULAR API
      # @option options :use_ssl force https, even if not needed
      #
      # @return a complete server address with protocol
      def server(options = {})
        "https://#{API_SERVER}"
      end


      # Adding open and read timeouts
      #
      # open timeout - the amount of time you are willing to wait for 'opening a connection'
      # (read) timeout - the amount of time you are willing to wait for some data to be received from the connected party.
      # @param conn - Faraday connection object
      #
      # @return the connection obj with the timeouts set if they have been initialized
      def add_timeouts(conn, options)
        conn.options.timeout = 50
        conn.options.open_timeout = 50
        conn
      end

      # Makes a request directly to Expedia.
      # @note You'll rarely need to call this method directly.
      #
      # @see Expedia::API#api
      #
      # @param path the server path for this request
      # @param args (see Expedia::API#api)
      # @param verb the HTTP method to use.
      # @param options same options passed to server method.
      #
      # @raise an appropriate connection error if unable to make the request to Expedia
      #
      # @return [Expedia::HTTPService::Response] on success. A response object representing the results from Expedia
      # @return [Expedia::APIError] on Error.
      def make_request(path, args, verb, options = {})
        args = common_parameters.merge(args)
        # figure out our options for this request
        request_options = {:params => (verb == :get ? args : {})}
        # set up our Faraday connection
        conn = Faraday.new(server(options), request_options)
        conn = add_timeouts(conn, options)
        response = conn.send(verb, path, (verb == :post ? args : {}))
        response
      end

      # Common Parameters required for every Call to Expedia Server.
      # @return [Hash] of all common parameters.
      def common_parameters
        {}
      end

    end

  end
end

