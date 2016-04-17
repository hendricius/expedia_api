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

      # returns a money object including the price. returns nil if there is no price
      def price
        if raw_data[:PackagePrice] && raw_data[:PackagePrice][:TotalPrice]
          Money.new(raw_data[:PackagePrice][:TotalPrice][:Value].to_f * 100, raw_data[:PackagePrice][:TotalPrice][:Currency])
        else
          nil
        end
      end

      # returns a money object with the savings, nil if there are no savings.
      def savings
        if raw_data[:PackagePrice] && raw_data[:PackagePrice][:TotalSavings]
          Money.new(raw_data[:PackagePrice][:TotalSavings][:Value].to_f * 100, raw_data[:PackagePrice][:TotalSavings][:Currency])
        else
          nil
        end
      end
    end
  end
end
