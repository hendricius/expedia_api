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
  let(:list) {
    stub_request(:get, "http://ews.expedia.com/wsapi/rest/package/v1/search/2016-09-07/HAM/SYD/2016-09-15/SYD/HAM?format=json&hotelids%5B%5D=1337&key=test").
    to_return(:status => 200, :body => ResponseMocks.package_search_multiple_stops_many_hotels.to_json, :headers => {})
    client.search_packages(sample_arguments)
  }
  describe "#test_data" do
    it "is a list" do
      assert_equal ExpediaApi::ResponseLists::Packages, list.class
    end
  end
end
