require 'test_helper'

describe ExpediaApi::Entities::FlightCombinationLegSegment do
  let(:raw_json) do
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
    }.with_indifferent_access
  end
  let(:raw_json_two) do
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
    }.with_indifferent_access
  end


  let(:entity) { ExpediaApi::Entities::FlightCombinationLegSegment.new(raw_json) }
  let(:entity_two) { ExpediaApi::Entities::FlightCombinationLegSegment.new(raw_json_two) }

  describe "#initialize" do
    it "creates a new package hotel object" do
      assert_equal ExpediaApi::Entities::FlightCombinationLegSegment, ExpediaApi::Entities::FlightCombinationLegSegment.new({}).class
    end
  end

  describe "#departure_time" do
    it "returns departure_time" do
      assert_equal DateTime, entity.departure_time.class
    end
  end

  describe "#arrival_time" do
    it "returns arrival_time" do
      assert_equal DateTime, entity.arrival_time.class
    end
  end

  describe "#index" do
    it "returns index" do
      assert_equal 1, entity.index
    end
  end

  describe "#carrier_code" do
    it "returns carrier_code" do
      assert_equal "AF", entity.carrier_code
    end
  end

  describe "#departure_airport_code" do
    it "returns departure_airport_code" do
      assert_equal "TXL", entity.departure_airport_code
    end
  end

  describe "#arrival_airport_code" do
    it "returns arrival_airport_code" do
      assert_equal "CDG", entity.arrival_airport_code
    end
  end

  describe "#stay_duration_seconds" do
    it "returns the previous segment" do
      entity.sibling_segments     = [entity, entity_two]
      assert_equal 9600, entity.stay_duration_seconds
      assert_equal 0, entity_two.stay_duration_seconds
    end
  end

  describe "#duration_seconds" do
    it "returns duration_seconds" do
      assert_equal 6600, entity.duration_seconds
    end
  end

  describe "#flight_number" do
    it "returns flight_number" do
      assert_equal "1135", entity.flight_number
    end
  end

  describe "#sibling_segments=" do
    it "allows setting a value" do
      entity.sibling_segments = [entity]
      assert_equal entity.sibling_segments.first, entity
    end
  end

  describe "#is_first_segment_of_flight?" do
    it "returns true if it is the first segment" do
      entity.sibling_segments = [entity, entity_two]
      assert_equal true, entity.is_first_segment_of_flight?
    end
  end

  describe "#is_last_segment_of_flight?" do
    it "returns true if it is the first segment" do
      entity.sibling_segments = [entity, entity_two]
      assert_equal true, entity_two.is_last_segment_of_flight?
    end
  end

  describe "#next_segment" do
    it "returns the next segment" do
      entity.sibling_segments = [entity, entity_two]
      assert_equal entity_two, entity.next_segment
    end

    it "returns nil if there are no segments" do
      entity.sibling_segments = [entity, entity_two]
      assert_equal nil, entity_two.next_segment
    end
  end

  describe "#previous_segment" do
    it "returns the previous segment" do
      entity.sibling_segments     = [entity, entity_two]
      entity_two.sibling_segments = [entity, entity_two]
      assert_equal entity, entity_two.previous_segment
    end

    it "returns nil if there are no segments" do
      entity.sibling_segments     = [entity, entity_two]
      entity_two.sibling_segments = [entity, entity_two]
      assert_equal nil, entity.previous_segment
    end
  end


end
