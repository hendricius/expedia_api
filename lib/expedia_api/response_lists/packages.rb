module ExpediaApi
  module ResponseLists
    class Packages < BaseResponseList

      def entries=(entries)
        if entries
          @entries = entries.map {|e| ExpediaApi::Entities::PackageEntity.new(e.with_indifferent_access) }
        else
          @entries = []
        end
      end

      def extract_entries_from_response(response)
        json = extract_data_from_response(response).with_indifferent_access
        return [] if json.empty?
        json = json.with_indifferent_access
        flights  = extract_flights(json[:FlightList][:Flight])
        hotels   = extract_hotels(json[:HotelList][:Hotel])
        packages = extract_packages(json["PackageSearchResultList"]["PackageSearchResult"], hotels: hotels, flights: flights)
        packages
      end

      def extract_flights(flights_json)
        # right now only 1 flight
        [ExpediaApi::Entities::PackageFlight.new(flights_json)]
      end

      def extract_hotels(hotels_json)
        hotels_json.map do |hotel|
          ExpediaApi::Entities::PackageHotel.new(hotel)
        end
      end

      # todo implement me
      def extract_packages(json, flights: [], hotels: [])
      end
    end

  end
end
