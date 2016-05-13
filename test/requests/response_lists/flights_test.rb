require 'test_helper'
require 'response_mocks'

describe ExpediaApi::ResponseLists::Flights do

  let(:client) { ExpediaApi::Client.new }
  let(:sample_arguments) do
    {
      from_date: Date.parse("2016-09-07"),
      to_date: Date.parse("2016-09-15"),
      from_airport: "TXL",
      to_airport: "BOB",
    }
  end
  let(:response_list) {
    stub_request(:get, "http://ews.expedia.com/xmlapi/rest/air/v2/airsearch/2016-09-07/TXL/BOB/2016-09-15/BOB/TXL?format=json&adult=1&key=test").
      to_return(:status => 200, :body => ResponseMocks.flights_list.to_json, :headers => {})

    client.search_flights(sample_arguments)
  }
  let(:outbound_legs_json) do
    parsed_reponse = JSON.parse(response_list.response.body).with_indifferent_access
    outbound_legs_json = parsed_reponse["AirLegListCollection"]["AirLegList"][0]["AirLeg"]
  end
  let(:return_legs_json) do
    parsed_reponse = JSON.parse(response_list.response.body).with_indifferent_access
    return_legs_json = parsed_reponse["AirLegListCollection"]["AirLegList"][1]["AirLeg"]
  end
  let(:products_json) do
    JSON.parse(response_list.response.body).with_indifferent_access[:AirProductList][:AirProduct]
  end

  describe "#test_data" do
    it "is a list" do
      assert_equal ExpediaApi::ResponseLists::Flights, response_list.class
    end
  end

  describe "#extract_legs" do
    let(:sample_leg_entity) do
      response_list.extract_legs(outbound_legs_json).first
    end
    it "returns an array of legs" do
      assert_equal ExpediaApi::Entities::FlightCombinationLeg, sample_leg_entity.class
    end
    it "has flight segments associated" do
      assert_equal Array, sample_leg_entity.segments.class
      assert_equal true,  sample_leg_entity.segments.length > 1
    end
  end

  describe "#extract_combinations" do
    let(:outbound_legs) { response_list.extract_legs(outbound_legs_json) }
    let(:return_legs)   { response_list.extract_legs(return_legs_json) }

    let(:sample_combinations) do
      response_list.extract_combinations(products_json, outbound_legs: outbound_legs, return_legs: return_legs)
    end

    let(:last_combination) do
      sample_combinations.last
    end

    it "receives both outbound and return legs" do
      assert_raises ArgumentError do
        response_list.extract_combinations({})
      end
    end

    it "returns an array of flight combinations" do
      assert_equal ExpediaApi::Entities::FlightCombination, sample_combinations.first.class
    end

    it "creates the right number of combinations" do
      assert_equal 12, sample_combinations.size
    end

    it "creates the right outbound to return leg association" do
      assert_equal 3, last_combination.outbound_leg.index
      assert_equal 8, last_combination.return_leg.index
    end
  end
end
