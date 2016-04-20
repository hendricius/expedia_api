require 'test_helper'
require 'response_mocks'

describe ExpediaApi::ResponseLists::Packages do

  let(:client) { ExpediaApi::Client.new }
  let(:sample_arguments) do
    {
      from_date: Date.parse("2016-09-07"),
      to_date: Date.parse("2016-09-15"),
      from_airport: "HAM",
      to_airport: "SYD",
      hotel_ids: [1337]
    }
  end
  let(:response_list) {
    stub_request(:get, "http://ews.expedia.com/wsapi/rest/package/v1/search/2016-09-07/HAM/SYD/2016-09-15/SYD/HAM?format=json&hotelids=1337&key=test").
    to_return(:status => 200, :body => ResponseMocks.package_search_multiple_stops_many_hotels.to_json, :headers => {})
    client.search_packages(sample_arguments)
  }
  let(:flights_json) do
    JSON.parse(response_list.response.body).with_indifferent_access[:FlightList][:Flight]
  end
  let(:hotels_json) do
    JSON.parse(response_list.response.body).with_indifferent_access[:HotelList][:Hotel]
  end
  let(:packages_json) do
    JSON.parse(response_list.response.body).with_indifferent_access[:PackageSearchResultList][:PackageSearchResult]
  end

  describe "#test_data" do
    it "is a list" do
      assert_equal ExpediaApi::ResponseLists::Packages, response_list.class
    end
  end

  describe "#extract_flights" do
    let(:sample_flight_entity) do
      response_list.extract_flights(flights_json).first
    end
    it "returns an array of flights" do
      assert_equal ExpediaApi::Entities::PackageFlight, sample_flight_entity.class
    end
    it "has flight legs associated" do
      assert_equal Array, sample_flight_entity.flight_legs.class
      assert_equal true, sample_flight_entity.flight_legs.length > 1
    end

    it "has flight segments associated" do
      assert_equal true, sample_flight_entity.flight_legs.first.segments.length > 1
    end
  end

  describe "#extract_hotels" do
    let(:sample_hotel_entity) do
      response_list.extract_hotels(hotels_json).first
    end
    it "returns an array array of hotels" do
      assert_equal ExpediaApi::Entities::PackageHotel, sample_hotel_entity.class
    end
  end

  describe "#extract_hotels" do
    let(:hotels) { response_list.extract_hotels(hotels_json) }
    let(:flights) { response_list.extract_flights(flights_json) }
    let(:sample_packages) do
      response_list.extract_packages(packages_json, hotels: hotels, flights: flights)
    end
    it "receives both hotels and flights" do
      assert_raises ArgumentError do
        response_list.extract_packages({})
      end
    end
    it "returns an array of packages" do
      assert_equal ExpediaApi::Entities::Package, sample_packages.first.class
    end
    it "associates hotels with each package" do
      assert_equal true, sample_packages.all? {|p| p.hotel.class == ExpediaApi::Entities::PackageHotel }
    end
    it "associates flights with each package" do
      assert_equal true, sample_packages.all? {|p| p.flight.class == ExpediaApi::Entities::PackageFlight }
    end
  end
end
