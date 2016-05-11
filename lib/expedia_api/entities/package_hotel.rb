module ExpediaApi
  module Entities
    class PackageHotel
      attr_reader :raw_data

      def initialize(raw_data)
        @raw_data = raw_data || {}
      end

      def index
        raw_data[:HotelIndex].to_i
      end

      # returns the hotel id
      def id
        raw_data[:HotelID].to_i
      end

      # returns the name of the hotel
      def name
        raw_data[:Name]
      end
    end
  end
end
