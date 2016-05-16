module ExpediaApi
  module ResponseLists
    class Packages < BaseResponseList

      def entries=(entries)
        @entries = entries
      end

      def extract_entries_from_response(response)
        json     = extract_data_from_response(response)
        return   [] if json.is_a?(Array) || json.empty?
        json     = json.with_indifferent_access
        flights  = extract_flights(extract_raw_flights_from_json(json))
        hotels   = extract_hotels(extract_raw_hotels_from_json(json))
        packages = extract_packages(extract_raw_packages_from_json(json), hotels: hotels, flights: flights)
        packages
      end

      # returns flights for each of the entries
      def extract_flights(flights_json)
        # right now only 1 flight
        [ExpediaApi::Entities::PackageFlight.new(flights_json)]
      end

      # returns hotels for each hotel in the json
      def extract_hotels(hotels_json)
        if hotels_json.is_a?(Array)
          hotels_json.map do |hotel|
            ExpediaApi::Entities::PackageHotel.new(hotel)
          end
        else
          [ExpediaApi::Entities::PackageHotel.new(hotels_json)]
        end
      end

      # returns packages for each of the json data
      def extract_packages(json, flights:, hotels:)
        flights_by_index = flights.map {|flight| [flight.index, flight]}.to_h
        hotels_by_index  = hotels.map {|hotel| [hotel.index, hotel]}.to_h
        # if only one package is returned, we just get a hash, no array.
        json = [json] if json.is_a?(Hash)
        json.map do |package|
          entity = ExpediaApi::Entities::Package.new(package)
          entity.flight = flights_by_index[entity.flight_index]
          entity.hotel  = hotels_by_index[entity.hotel_index]
          entity
        end
      end

      # returns the flight data extracted from the json
      def extract_raw_flights_from_json(json)
        if json[:FlightList] && json[:FlightList][:Flight]
          json[:FlightList][:Flight]
        else
          []
        end
      end

      # returns the hotel data extracted fron the json
      def extract_raw_hotels_from_json(json)
        if json[:HotelList] && json[:HotelList][:Hotel]
          json[:HotelList][:Hotel]
        else
          []
        end
      end

      # returns the package data extracted from the json
      def extract_raw_packages_from_json(json)
        if json[:PackageSearchResultList] && json[:PackageSearchResultList][:PackageSearchResult]
          json[:PackageSearchResultList][:PackageSearchResult]
        else
          []
        end
      end
    end

  end
end
