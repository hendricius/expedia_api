require 'faraday'

module ExpediaApi
  module HTTPService

    API_SERVER = 'ews.expedia.com'
    API_PATH   = 'wsapi/rest/hotel/v1/search'

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

      # paramters:
      # location:
      #   example:
      #     40.714269,-74.005973
      #   description:
      #     The composition of latitude and longitude values
      #     identifying the center point of a hotel search radius (circle). The
      #     latitude and longitude values are joined together with a comma (,)
      #     character.
      #   remark:
      #     When this parameter is used, the RADIUS parameter is required.
      # radius:
      #   example:
      #     10km
      #   description:
      #     The size of the hotel search radius around the specified latitude
      #     and longitude, along with its associated unit of measure.
      #     The units default to kilometers if a value isn't provided in the composition.
      #     Valid units are KM and MI.
      #   remark:
      #     Radius must be less than 200.0km/124.30081 miles. The radius only
      #     applies to the LOCATION parameter.
      # hotelids:
      #   example:
      #     28082, 11133
      #   description:
      #     Comma-separated list of Hotel IDs for which to return results.
      # regionids:
      #   example:
      #     8816, 1234
      #   description:
      #     Comma-separated list of Expedia Region IDs. Searching is done for
      #     all hotels in the regions.
      # dates:
      #   example:
      #     2011-01-19,2011-01-20
      #   description:
      #     Comma separated list of check- in/check-out dates for hotel stay
      #     in an ISO 8601 Date format [YYYY-MM-DD]. If this parameter is not
      #     included, a dateless search will be conducted which returns a
      #     featured offer for each of the hotels found.
      #   remark:
      #     Max advance search window is 330 days.
      # language:
      #   example:
      #     en-US
      #   description:
      #     language is composed of language code and country code, connected by
      #     "-". Must be a valid language for the Point of Sale. For example,
      #     "fr-FR"/"fr- CA" is a valid language for France/Canada site, but
      #     could not be "fr-US". If no language is specified, a default
      #     language will be used.
      # currency:
      #   example:
      #     USD
      #   description:
      #     Value should be a standard ISO. 3 letter currency code, e.g. CAD -
      #     Canadian dollar, USD - US dollar
      #     If not specified for dated searches, USD will be returned.
      #     If not specified for dateless searches, the pos native currency
      #     will be returned.
      # adults:
      #   example:
      #     2,1
      #   description:
      #     Comma-separated list that specifies the number of adults staying in
      #     each of the rooms to be requested.
      #   remark:
      #     Default value will be 2 if not specified. It indicates only one room
      #     is required and there are two adults staying in the room. Up to 8
      #     rooms can be requested at a time.
      #
      #     Example:
      #     adults=2,2,2,2 (four rooms with two adults in each room))
      # availonly:
      #   example:
      #     true
      #   description:
      #     return available hotels only. default: true
      def make_request(request_options: {}, parameters: {})
        args = common_parameters.merge(parameters)
        # figure out our options for this request
        # set up our Faraday connection
        conn = Faraday.new(server)
        conn = add_timeouts(conn, options)
        response = conn.send(:get, API_PATH, args)
        response
      end

      # Common Parameters required for every Call to Expedia Server.
      # @return [Hash] of all common parameters.
      def common_parameters
        {
          :format       => :json,
          :key          => ExpediaApi::Key
        }
      end

    end

  end
end

