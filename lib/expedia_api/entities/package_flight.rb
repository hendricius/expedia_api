module ExpediaApi
  module Entities
    class PackageFlight
      attr_reader :raw_data

      def initialize(raw_data)
        @raw_data = raw_data || {}
      end

      def index
        raw_data[:FlightIndex]
      end

      def flight_legs
        extract_flightlegs.map do |leg|
          FlightLeg.new(leg)
        end
      end

      def extract_flightlegs
        raw_data.fetch(:FlightItinerary, {}).fetch(:FlightLeg, {})
      end

      class FlightLeg
        def initialize(raw_data)
          @raw_data = raw_data || {}
        end

        def segments
          extract_segments.map do |segment|
            FlightLegSegment.new(segment)
          end
        end

        def extract_segments
          @raw_data[:FlightSegment] || []
        end
      end

      class FlightLegSegment
        def initialize(raw_data)
          @raw_data = raw_data || {}
        end
      end
    end
  end
end
