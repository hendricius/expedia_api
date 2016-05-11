module ExpediaApi
  module Entities
    class PackageFlightLeg
      def initialize(raw_data)
        @raw_data = raw_data || {}
      end

      # returns the flight segments of the flight
      def segments
        @segments ||= begin
          extract_segments.map do |segment|
            PackageFlightLegSegment.new(segment)
          end
        end
      end

      # extracts the segments of the flight from the json
      def extract_segments
        @raw_data[:FlightSegment] || []
      end

      # returns the total time it will in seconds.
      def total_duration_seconds
        0
      end
    end
  end
end
