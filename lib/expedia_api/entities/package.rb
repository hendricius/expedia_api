module ExpediaApi
  module Entities
    class Package
      attr_accessor :flight, :hotel
      attr_reader :raw_data

      def initialize(raw_data)
        @raw_data = raw_data || {}
      end

      def flight_index
        raw_data[:FlightReferenceIndex].to_i
      end

      def hotel_index
        raw_data[:HotelReferenceIndex].to_i
      end

      def price
        # todo
      end

      def savings
        # todo
      end
    end
  end
end
