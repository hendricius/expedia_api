require 'test_helper'

describe ExpediaApi::Entities::FlightCombinationLeg do
  let(:raw_json) do
    {
      "AirLegIndex":1,
      "AirSegmentList":{
        "AirSegment":[
          {
            "AirCarrierCode": "AF",
            "AirProviderCode": "1",
            "AirSegmentIndex":1,
            "ArrivalDateTime": "2016-09-07T08:50:00+02:00",
            "ArrivalLocationCode": "CDG",
            "DepartureDateTime": "2016-09-07T07:00:00+02:00",
            "DepartureLocationCode": "TXL",
            "FlightDuration": "PT1H50M",
            "FlightNumber": "1135",
            "OperationSegmentList":{
              "OperationSegment":[
                {
                  "AircraftCode": "320",
                  "ArrivalDateTime": "2016-09-07T08:50:00+02:00",
                  "ArrivalLocationCode": "CDG",
                  "DepartureDateTime": "2016-09-07T07:00:00+02:00",
                  "DepartureLocationCode": "TXL",
                  "FlightDuration": "PT1H50M",
                  "OperationSegmentIndex":1
                }
              ]
            }
          },
          {
            "AirCarrierCode": "TN",
            "AirProviderCode": "1",
            "AirSegmentIndex":2,
            "ArrivalDateTime": "2016-09-07T22:00:00-10:00",
            "ArrivalLocationCode": "PPT",
            "DepartureDateTime": "2016-09-07T11:30:00+02:00",
            "DepartureLocationCode": "CDG",
            "FlightDuration": "PT22H30M",
            "FlightNumber": "7",
            "OperationSegmentList":{
              "OperationSegment":[
                {
                  "AircraftCode": "343",
                  "ArrivalDateTime": "2016-09-07T22:00:00-10:00",
                  "ArrivalLocationCode": "PPT",
                  "DepartureDateTime": "2016-09-07T11:30:00+02:00",
                  "DepartureLocationCode": "CDG",
                  "FlightDuration": "PT22H30M",
                  "OperationSegmentIndex":1
                }
              ]
            }
          },
          {
            "AirCarrierCode": "VT",
            "AirProviderCode": "1",
            "AirSegmentIndex":3,
            "ArrivalDateTime": "2016-09-08T07:35:00-10:00",
            "ArrivalLocationCode": "BOB",
            "DepartureDateTime": "2016-09-08T06:45:00-10:00",
            "DepartureLocationCode": "PPT",
            "FlightDuration": "PT50M",
            "FlightNumber": "487",
            "OperationSegmentList":{
              "OperationSegment":[
                {
                  "AircraftCode": "AT7",
                  "ArrivalDateTime": "2016-09-08T07:35:00-10:00",
                  "ArrivalLocationCode": "BOB",
                  "DepartureDateTime": "2016-09-08T06:45:00-10:00",
                  "DepartureLocationCode": "PPT",
                  "FlightDuration": "PT50M",
                  "OperationSegmentIndex":1
                }
              ]
            }
          }
        ]
      },
      "FlightDuration": "PT36H35M0S",
      "TotalStops":2
    }.with_indifferent_access
  end

  let(:entity) { ExpediaApi::Entities::FlightCombinationLeg.new(raw_json) }

  describe "#segments" do
    it "returns an array of segments" do
      assert_equal true, entity.segments.all? {|s| s.class == ExpediaApi::Entities::FlightCombinationLegSegment }
    end
    it "returns 3 segments for the sample data" do
      assert_equal 3, entity.segments.length
    end
  end

  describe "#index" do
    it "returns the index of the flight leg" do
      assert_equal 1, entity.index
    end
  end

  describe "#total_duration_seconds" do
    it "returns the travel time of the flight leg" do
      assert_equal (36 * 3600 + 35 * 60), entity.total_duration_seconds
    end
  end

end
