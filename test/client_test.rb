require 'test_helper'
require 'response_mocks'

describe ExpediaApi::Client do
  before(:each) do
    ExpediaApi.api_key = "test"
  end
  let(:client) { ExpediaApi::Client.new }
  describe "#initialize" do
    it "returns a client object" do
      assert_equal ExpediaApi::Client, ExpediaApi::Client.new.class
    end
  end

  describe "#search_hotels" do
    it "returns a response class item" do
      stub_request(:any, "http://ews.expedia.com/wsapi/rest/hotel/v1/search?format=json&key=test").
        to_return(:status => 200, :body => "[]", :headers => {})
      assert_equal ExpediaApi::ResponseLists::Hotels, ExpediaApi::Client.new.search_hotels.class
    end
    it "returns an empty array if no data is returned" do
      stub_request(:any, "http://ews.expedia.com/wsapi/rest/hotel/v1/search?format=json&key=test").
        to_return(:status => 200, :body => "[]", :headers => {})
      assert_equal 0, ExpediaApi::Client.new.search_hotels.entries.length
    end
    it "includes an exception if one is risen" do
      stub_request(:any, "http://ews.expedia.com/wsapi/rest/hotel/v1/search?format=json&key=test").to_raise(Faraday::ConnectionFailed)
      assert_equal true, ExpediaApi::Client.new.search_hotels.error?
      assert ExpediaApi::Client.new.search_hotels.exception
    end
    it "returns data for one item in the response" do
      stub_request(:any, "http://ews.expedia.com/wsapi/rest/hotel/v1/search?format=json&key=test").
        to_return(:status => 200, :body => ResponseMocks.one_entry, :headers => {})
      assert_equal Array, ExpediaApi::Client.new.search_hotels.entries.class
      assert_equal 1, ExpediaApi::Client.new.search_hotels.entries.length
    end
    it "returns data for two items in the response" do
      stub_request(:any, "http://ews.expedia.com/wsapi/rest/hotel/v1/search?format=json&key=test").
        to_return(:status => 200, :body => ResponseMocks.two_entries, :headers => {})
      assert_equal Array, ExpediaApi::Client.new.search_hotels.entries.class
      assert_equal 2, ExpediaApi::Client.new.search_hotels.entries.length
    end
    it "returns an array of SearchEntity objects" do
      stub_request(:any, "http://ews.expedia.com/wsapi/rest/hotel/v1/search?format=json&key=test").
        to_return(:status => 200, :body => ResponseMocks.two_entries, :headers => {})
      assert_equal ExpediaApi::Entities::SearchEntity, ExpediaApi::Client.new.search_hotels.entries.first.class
    end
  end

  describe "#search_packages" do
    let(:sample_arguments) do
      {
        from_date: Date.parse("2016-09-07"),
        to_date: Date.parse("2016-09-15"),
        from_airport: "HAM",
        to_airport: "SYD",
        hotel_ids: [1337]
      }
    end
    it "raises an ArgumentError if invalid parameters are passed" do
      assert_raises ArgumentError do
         client.search_packages
      end
      # hotel ids or region ids must be there
      assert_raises ArgumentError do
        client.search_packages(from_date: Date.new, to_date: Date.new, from_airport: "HAM", to_airport: "FUH")
      end
      # airport must be there
      assert_raises ArgumentError do
        client.search_packages(from_date: Date.new, to_date: Date.new)
      end
    end
    it "returns a package response list do" do
      stub_request(:get, "http://ews.expedia.com/wsapi/rest/package/v1/search/2016-09-07/HAM/SYD/2016-09-15/SYD/HAM?format=json&hotelids=1337&key=test").
        to_return(:status => 200, :body => ResponseMocks.package_search_multiple_stops_many_hotels.to_json, :headers => {})

      data = client.search_packages(sample_arguments)
      assert_equal ExpediaApi::ResponseLists::Packages, data.class
    end
  end

  describe "#build_package_search_request_path" do
    it "returns the path" do
      arguments = {
        from_date: Date.parse("2016-09-07"),
        to_date: Date.parse("2016-09-15"),
        from_airport: "HAM",
        to_airport: "SYD"
      }
      assert_equal "2016-09-07/HAM/SYD/2016-09-15/SYD/HAM", client.send(:build_package_search_request_path, arguments)
    end
  end
end
