module ExpediaApi
  # All method naming is done in correspondence with Expedia services and ruby conventions
  class Client


    # @param args [Hash] All the params required for 'get_list' call
    # @return [Expedia::HTTPService::Response] on success. A response object representing the results from Expedia
    # @return [Expedia::APIError] on Error.
    # @note A POST request is made instead of GET if 'hotelIdList' length > 200
    def get_list(args)
      method = (args[:hotelIdList] || args["hotelIdList"] || []).length > 200 ? :post : :get
      services('/ean-services/rs/hotel/v3/list', args, method)
    end

    private

    def services(path, args, method=:get)
      HTTPService.make_request(path, args, method)
    end

  end
end

