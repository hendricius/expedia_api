module ExpediaApi
  module Entities
    # wrapper class for each of the flight legs
    class FlightCombinationLeg

      # The raw data by the API looks like this:
      #
      # {
      #   "AirLegIndex":1,
      #   "AirSegmentList":{
      #     "AirSegment":[
      #       {
      #         "AirCarrierCode": "AF",
      #         "AirProviderCode": "1",
      #         "AirSegmentIndex":1,
      #         "ArrivalDateTime": "2016-09-07T08:50:00+02:00",
      #         "ArrivalLocationCode": "CDG",
      #         "DepartureDateTime": "2016-09-07T07:00:00+02:00",
      #         "DepartureLocationCode": "TXL",
      #         "FlightDuration": "PT1H50M",
      #         "FlightNumber": "1135",
      #         "OperationSegmentList":{
      #           "OperationSegment":[
      #             {
      #               "AircraftCode": "320",
      #               "ArrivalDateTime": "2016-09-07T08:50:00+02:00",
      #               "ArrivalLocationCode": "CDG",
      #               "DepartureDateTime": "2016-09-07T07:00:00+02:00",
      #               "DepartureLocationCode": "TXL",
      #               "FlightDuration": "PT1H50M",
      #               "OperationSegmentIndex":1
      #             }
      #           ]
      #         }
      #       },
      #       {
      #         "AirCarrierCode": "TN",
      #         "AirProviderCode": "1",
      #         "AirSegmentIndex":2,
      #         "ArrivalDateTime": "2016-09-07T22:00:00-10:00",
      #         "ArrivalLocationCode": "PPT",
      #         "DepartureDateTime": "2016-09-07T11:30:00+02:00",
      #         "DepartureLocationCode": "CDG",
      #         "FlightDuration": "PT22H30M",
      #         "FlightNumber": "7",
      #         "OperationSegmentList":{
      #           "OperationSegment":[
      #             {
      #               "AircraftCode": "343",
      #               "ArrivalDateTime": "2016-09-07T22:00:00-10:00",
      #               "ArrivalLocationCode": "PPT",
      #               "DepartureDateTime": "2016-09-07T11:30:00+02:00",
      #               "DepartureLocationCode": "CDG",
      #               "FlightDuration": "PT22H30M",
      #               "OperationSegmentIndex":1
      #             }
      #           ]
      #         }
      #       },
      #       {
      #         "AirCarrierCode": "VT",
      #         "AirProviderCode": "1",
      #         "AirSegmentIndex":3,
      #         "ArrivalDateTime": "2016-09-08T07:35:00-10:00",
      #         "ArrivalLocationCode": "BOB",
      #         "DepartureDateTime": "2016-09-08T06:45:00-10:00",
      #         "DepartureLocationCode": "PPT",
      #         "FlightDuration": "PT50M",
      #         "FlightNumber": "487",
      #         "OperationSegmentList":{
      #           "OperationSegment":[
      #             {
      #               "AircraftCode": "AT7",
      #               "ArrivalDateTime": "2016-09-08T07:35:00-10:00",
      #               "ArrivalLocationCode": "BOB",
      #               "DepartureDateTime": "2016-09-08T06:45:00-10:00",
      #               "DepartureLocationCode": "PPT",
      #               "FlightDuration": "PT50M",
      #               "OperationSegmentIndex":1
      #             }
      #           ]
      #         }
      #       }
      #     ]
      #   },
      #   "FlightDuration": "PT36H35M0S",
      #   "TotalStops":2
      # }

      def initialize(raw_data)
        @raw_data = raw_data || {}
      end

      # returns the flight segments of the flight
      def segments
        @segments ||= begin
          segments = extract_segments.map do |segment|
            PackageFlightLegSegment.new(segment)
          end
          segments.each do |segment|
            segment.sibling_segments = segments
          end
          segments
        end
      end

      # extracts the segments of the flight from the json
      def extract_segments
        @raw_data[:AirSegmentList][:AirSegment] || []
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
        @raw_data[:AirLegIndex].to_i
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
