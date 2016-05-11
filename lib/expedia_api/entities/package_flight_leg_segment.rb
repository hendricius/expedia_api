module ExpediaApi
  module Entities
    # class handling each of the flight legs segments
    #
    # receives data in this format:
    # {
    #   "FlightSegmentIndex"=>"2",
    #   "DepartureAirportCode"=>"SAW",
    #   "ArrivalAirportCode"=>"DXB",
    #   "DepartureDateTime"=>"2016-05-31T21:45:00",
    #   "ArrivalDateTime"=>"2016-06-01T03:20:00",
    #   "CarrierCode"=>"PC",
    #   "FlightNumber"=>"5660",
    #   "FlightDuration"=>"PT4H35M"
    # }
    class PackageFlightLegSegment

      attr_accessor :sibling_segments

      def initialize(raw_data)
        @raw_data         = raw_data || {}
        @sibling_segments = []
      end

      # returns a departure datetime for the departure time of the segment
      def departure_time
        DateTime.parse(@raw_data[:DepartureDateTime])
      end

      # returns a datetime for the arrival date of the segment
      def arrival_time
        DateTime.parse(@raw_data[:ArrivalDateTime])
      end

      # returns the index of the segment
      def index
        @raw_data[:FlightSegmentIndex].to_i
      end

      # returns the carrier code of the segment
      def carrier_code
        @raw_data[:CarrierCode]
      end

      # returns the departure airport code of the segment
      def departure_airport_code
        @raw_data[:DepartureAirportCode]
      end

      # returns the arrival airport code of the segment
      def arrival_airport_code
        @raw_data[:ArrivalAirportCode]
      end

      # returns the time between this segment and the next one.
      def stay_duration_seconds
        return 0 unless next_segment
        # when we arrive at the next airport, minus when we arrived at this
        # airport.
        (next_segment.departure_time.to_time - arrival_time.to_time).to_i
      end

      # returns the duration how long the segment takes. returns 0 if it can
      # not be identified.
      def duration_seconds
        hours   = hours_flight
        minutes = minutes_flight
        if hours && minutes
          hours * 3600 + minutes * 60
        else
          0
        end
      end

      # returns the hours of the flight, if nor parsable, returns nil
      def hours_flight
        stamp = @raw_data[:FlightDuration].split("PT")[1]
        stamp.split("H")[0].to_i
      rescue
        nil
      end

      # returns the minutes of the flight, if nor parsable, returns nil
      def minutes_flight
        stamp = @raw_data[:FlightDuration].split("PT")[1]
        stamp.split("H")[1].split("M")[0].to_i
      rescue
        nil
      end

      # returns the flight number of the flight
      def flight_number
        @raw_data[:FlightNumber]
      end

      # returns true if it is the last segment of the flight
      def is_last_segment_of_flight?
        return true if sibling_segments.empty?
        sibling_segments.sort_by {|segment| segment.index }.reverse.first == self
      end

      # returns true if it is the first segment of the flight
      def is_first_segment_of_flight?
        return true if sibling_segments.empty?
        sibling_segments.sort_by {|segment| segment.index }.first == self
      end

      # returns the next segment followed by this segment
      def next_segment
        return nil if sibling_segments.empty?
        sibling_segments[sibling_segments.sort_by(&:index).index(self) + 1]
      end

      # returns the previous segment preceeded by this segment
      def previous_segment
        return nil if sibling_segments.empty?
        index = sibling_segments.sort_by(&:index).index(self)
        if index && index >= 1
          sibling_segments[index - 1]
        else
          nil
        end
      end
    end
  end
end
