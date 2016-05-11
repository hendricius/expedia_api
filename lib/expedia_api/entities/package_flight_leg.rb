module ExpediaApi
  module Entities
    # wrapper class for each of the flight legs
    class PackageFlightLeg

      # The raw data by the API looks like this:
      #
      # {
      #   "FlightDuration": "PT21H50M",
      #   "FlightLegIndex": "1",
      #   "FlightSegment": [
      #     {
      #       "ArrivalAirportCode": "DUS",
      #       "ArrivalDateTime": "2016-09-07T08:30:00",
      #       "CarrierCode": "AB",
      #       "DepartureAirportCode": "HAM",
      #       "DepartureDateTime": "2016-09-07T07:30:00",
      #       "FlightDuration": "PT1H0M",
      #       "FlightNumber": "6743",
      #       "FlightSegmentIndex": "1"
      #     },
      #     {
      #       "ArrivalAirportCode": "AUH",
      #       "ArrivalDateTime": "2016-09-07T20:20:00",
      #       "CarrierCode": "AB",
      #       "DepartureAirportCode": "DUS",
      #       "DepartureDateTime": "2016-09-07T11:30:00",
      #       "FlightDuration": "PT6H50M",
      #       "FlightNumber": "4008",
      #       "FlightSegmentIndex": "2"
      #     },
      #     {
      #       "ArrivalAirportCode": "SYD",
      #       "ArrivalDateTime": "2016-09-08T17:55:00",
      #       "CarrierCode": "AB",
      #       "DepartureAirportCode": "AUH",
      #       "DepartureDateTime": "2016-09-07T21:55:00",
      #       "FlightDuration": "PT14H0M",
      #       "FlightNumber": "4070",
      #       "FlightSegmentIndex": "3"
      #     }
      #   ]
      # }
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
      #
      # format by expedia: "PT21H50M"
      def total_duration_seconds
        hours   = hours_all_segments
        minutes = minutes_all_segments
        if hours && minutes
          hours * 3600 + minutes * 60
        else
          0
        end
      end

      # returns the hours of the flight, if nor parsable, returns nil
      def hours_all_segments
        stamp = @raw_data[:FlightDuration].split("PT")[1]
        stamp.split("H")[0].to_i
      rescue
        nil
      end

      # returns the minutes of the flight, if nor parsable, returns nil
      def minutes_all_segments
        stamp = @raw_data[:FlightDuration].split("PT")[1]
        stamp.split("H")[1].split("M")[0].to_i
      rescue
        nil
      end

      # returns the index of the flight leg
      def index
        @raw_data[:FlightLegIndex].to_i
      end

      # returns true if we have a to flight
      def is_to_flight?
        index == 1
      end

      # returns true if we have a return flight leg.
      def is_return_flight?
        index == 2
      end
    end
  end
end
