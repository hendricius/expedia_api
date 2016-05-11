require 'test_helper'

describe ExpediaApi::Entities::PackageFlightLeg do
  let(:raw_json) do
    {
        "FlightDuration": "PT21H50M",
        "FlightLegIndex": "1",
        "FlightSegment": [
            {
                "ArrivalAirportCode": "DUS",
                "ArrivalDateTime": "2016-09-07T08:30:00",
                "CarrierCode": "AB",
                "DepartureAirportCode": "HAM",
                "DepartureDateTime": "2016-09-07T07:30:00",
                "FlightDuration": "PT1H0M",
                "FlightNumber": "6743",
                "FlightSegmentIndex": "1"
            },
            {
                "ArrivalAirportCode": "AUH",
                "ArrivalDateTime": "2016-09-07T20:20:00",
                "CarrierCode": "AB",
                "DepartureAirportCode": "DUS",
                "DepartureDateTime": "2016-09-07T11:30:00",
                "FlightDuration": "PT6H50M",
                "FlightNumber": "4008",
                "FlightSegmentIndex": "2"
            },
            {
                "ArrivalAirportCode": "SYD",
                "ArrivalDateTime": "2016-09-08T17:55:00",
                "CarrierCode": "AB",
                "DepartureAirportCode": "AUH",
                "DepartureDateTime": "2016-09-07T21:55:00",
                "FlightDuration": "PT14H0M",
                "FlightNumber": "4070",
                "FlightSegmentIndex": "3"
            }
        ]
    }.with_indifferent_access
  end

  let(:entity) { ExpediaApi::Entities::PackageFlightLeg.new(raw_json) }

  describe "#initialize" do
    it "creates a new package hotel object" do
      assert_equal ExpediaApi::Entities::PackageFlightLeg, ExpediaApi::Entities::PackageFlightLeg.new({}).class
    end
  end

  describe "#segments" do
    it "returns an array of segments" do
      assert_equal true, entity.segments.all? {|s| s.class == ExpediaApi::Entities::PackageFlightLegSegment }
    end
    it "returns 3 segments for the sample data" do
      assert_equal 3, entity.segments.length
    end
  end

  describe "#is_to_flight?" do
    it "returns true if it is the to flight" do
      assert_equal true, entity.is_to_flight?
    end
    it "returns false if it is the to flight" do
      raw_json[:FlightLegIndex] = 2
      assert_equal false, entity.is_to_flight?
    end
  end

  describe "#index" do
    it "returns the index of the flight leg" do
      assert_equal 1, entity.index
    end
  end

  describe "#is_return_flight?" do
    it "returns true if it is the return flight" do
      assert_equal false, entity.is_return_flight?
    end
    it "returns false if it is the to flight" do
      raw_json[:FlightLegIndex] = 2
      assert_equal true, entity.is_return_flight?
    end
  end

  describe "#total_duration_seconds" do
    it "returns the travel time of the flight leg" do
      assert_equal (21 * 3600 + 50 * 60), entity.total_duration_seconds
    end
  end


end
