module ExpediaApi
  module ResponseLists
    class Packages < BaseResponseList

      def entries=(entries)
        @entries = entries.map {|e| ExpediaApi::Entities::PackageEntity.new(e.with_indifferent_access) }
      end
      def extract_entries_from_response(response)
        # probably an error ocurred connecting
        if response.nil?
          return []
        end
        body = nil
        begin
          body = JSON.parse(response.body)
        rescue JSON::ParserError => e
          @exception = e
          return []
        end
        if !body.is_a?(Hash) || body.nil?
          return []
        end
        # implement me
        return []
        hotel_count = body["HotelCount"].to_i
        if hotel_count == 1
          [body["HotelInfoList"]["HotelInfo"]]
        elsif hotel_count > 1
          body["HotelInfoList"]["HotelInfo"]
        else
          []
        end
      end
    end

  end
end
