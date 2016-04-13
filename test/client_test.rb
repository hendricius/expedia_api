require 'test_helper'
require 'response_mocks'

describe ExpediaApi::Client do
  before(:each) do
    ExpediaApi.api_key = "test"
  end
  describe "#initialize" do
    it "returns a client object" do
      assert_equal ExpediaApi::Client, ExpediaApi::Client.new.class
    end
  end

  describe "#search_hotels" do
    it "returns a response class item" do
      stub_request(:any, "http://ews.expedia.com/wsapi/rest/hotel/v1/search?format=json&key=test").
        to_return(:status => 200, :body => "[]", :headers => {})
      assert_equal ExpediaApi::HotelResponseList, ExpediaApi::Client.new.search_hotels.class
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
    let(:client) { ExpediaApi::Client.new }
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
  end
end
