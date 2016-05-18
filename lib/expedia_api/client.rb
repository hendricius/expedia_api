module ExpediaApi
  # All method naming is done in correspondence with Expedia services and ruby conventions
  class Client

    # parameters:
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
    def search_hotels(parameters = {})
      data = request(parameters: parameters, uri: 'wsapi/rest/hotel/v1/search')
      ExpediaApi::ResponseLists::Hotels.new(response: data)
    rescue Faraday::ParsingError => e
      ExpediaApi::ResponseLists::Hotels.new(exception: e)
    rescue Faraday::ConnectionFailed => e
      ExpediaApi::ResponseLists::Hotels.new(exception: e)
    end

    def search_flights(from_date:, to_date:, from_airport:, to_airport:, other_options: {})
      parameters = {adult:1}.merge(other_options)
      path_uri = build_package_search_request_path(from_airport: from_airport, to_airport: to_airport, from_date: from_date, to_date: to_date)
      # build the url for the request to match the specifications
      path_uri = build_flight_search_request_path(from_airport: from_airport, to_airport: to_airport, from_date: from_date, to_date: to_date)
      base_uri = "/xmlapi/rest/air/v2/airsearch"
      full_uri = "#{base_uri}/#{path_uri}"
      data = request(parameters: parameters, uri: full_uri)
      ExpediaApi::ResponseLists::Flights.new(response: data)
    rescue Faraday::ParsingError => e
      ExpediaApi::ResponseLists::Flights.new(exception: e)
    rescue Faraday::ConnectionFailed => e
      ExpediaApi::ResponseLists::Flights.new(exception: e)
    end

    def search_packages(hotel_ids: [], region_ids: [], from_date:, to_date:, from_airport:, to_airport:, piid: nil, other_options: {})
      # convert/validate the parameters. the api expects a comma separated
      # string.
      hotel_ids  = hotel_ids.join(",") if hotel_ids.is_a?(Array) && hotel_ids.any?
      region_ids = region_ids.join(",") if region_ids.is_a?(Array) && region_ids.any?
      validate_package_arguments({hotel_ids: hotel_ids, region_ids: region_ids})
      parameters = {}.merge(other_options)
      parameters[:hotelids]  = hotel_ids   if hotel_ids.length
      parameters[:regionids] = region_ids  if region_ids.length
      parameters[:piid]      = piid        if piid
      # build the url for the request to match the specifications
      path_uri = build_package_search_request_path(from_airport: from_airport, to_airport: to_airport, from_date: from_date, to_date: to_date)
      base_uri = "/wsapi/rest/package/v1/search"
      full_uri = "#{base_uri}/#{path_uri}"
      data = request(parameters: parameters, uri: full_uri)
      ExpediaApi::ResponseLists::Packages.new(response: data)
    rescue Faraday::ParsingError => e
      ExpediaApi::ResponseLists::Packages.new(exception: e)
    rescue Faraday::ConnectionFailed => e
      ExpediaApi::ResponseLists::Packages.new(exception: e)
    end

    private

    def request(request_options: {}, parameters: {}, uri:)
      HTTPService.perform_request(request_options: request_options, parameters: parameters, uri: uri)
    end

    def validate_package_arguments(args)
      if args[:hotel_ids].empty? && args[:region_ids].empty?
        raise ArgumentError
      end
      true
    end

    def build_package_search_request_path(from_airport:, to_airport:, from_date:, to_date:)
      from_date = from_date.strftime("%F")
      to_date   = to_date.strftime("%F")
      "#{from_date}/#{from_airport}/#{to_airport}/#{to_date}/#{to_airport}/#{from_airport}"
    end

    def build_flight_search_request_path(from_airport:, to_airport:, from_date:, to_date:)
      from_date = from_date.strftime("%F")
      to_date   = to_date.strftime("%F")
      "#{from_date}/#{from_airport}/#{to_airport}/#{to_date}/#{to_airport}/#{from_airport}"
    end
  end
end
