require 'test_helper'

describe ExpediaApi::Entities::PackageHotel do
  let(:raw_json) do
    {
      "FlightSegmentIndex"=>"2",
      "DepartureAirportCode"=>"SAW",
      "ArrivalAirportCode"=>"DXB",
      "DepartureDateTime"=>"2016-05-31T21:45:00",
      "ArrivalDateTime"=>"2016-06-01T03:20:00",
      "CarrierCode"=>"PC",
      "FlightNumber"=>"5660",
      "FlightDuration"=>"PT4H35M"
    }.with_indifferent_access
  end

  let(:entity) { ExpediaApi::Entities::PackageFlightLegSegment.new(raw_json) }

  describe "#initialize" do
    it "creates a new package hotel object" do
      assert_equal ExpediaApi::Entities::PackageFlightLegSegment, ExpediaApi::Entities::PackageFlightLegSegment.new({}).class
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
      assert_equal 2, entity.index
    end
  end

  describe "#carrier_code" do
    it "returns carrier_code" do
      assert_equal "PC", entity.carrier_code
    end
  end

  describe "#departure_airport_code" do
    it "returns departure_airport_code" do
      assert_equal "SAW", entity.departure_airport_code
    end
  end

  describe "#arrival_airport_code" do
    it "returns arrival_airport_code" do
      assert_equal "DXB", entity.arrival_airport_code
    end
  end

  describe "#stay_duration_seconds" do
    it "returns stay_duration_seconds" do
      skip
    end
  end

  describe "#duration_seconds" do
    it "returns duration_seconds" do
      assert_equal 16500, entity.duration_seconds
    end
  end

  describe "#flight_number" do
    it "returns flight_number" do
      assert_equal "5660", entity.flight_number
    end
  end


end
