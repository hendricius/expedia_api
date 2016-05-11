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

      def initialize(raw_data)
        @raw_data = raw_data || {}
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
        0
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
    end
  end
end
