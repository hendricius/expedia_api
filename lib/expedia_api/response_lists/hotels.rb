module ExpediaApi
  module ResponseLists
    class Hotels < BaseResponseList

      def entries=(entries)
        if entries
          @entries = entries.map {|e| ExpediaApi::Entities::SearchEntity.new(e.with_indifferent_access) }
        else
          @entries = []
        end
      end

      def extract_entries_from_response(response)
        body = extract_data_from_response(response)
        return [] if body.empty?
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
