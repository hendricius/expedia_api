require 'test_helper'
require 'response_mocks'

describe ExpediaApi::Client do
  describe "initialize" do
    it "returns a client object" do
      assert_equal ExpediaApi::Client, ExpediaApi::Client.new.class
    end
  end

  describe "get_list" do
    it "returns a response class item" do
      stub_request(:any, "https://ews.expedia.com/wsapi/rest/hotel/v1/search").
        to_return(:status => 200, :body => [], :headers => {})
      assert_equal ExpediaApi::HotelResponseList, ExpediaApi::Client.new.get_list.class
    end
    it "returns an empty array if no data is returned" do
      stub_request(:any, "https://ews.expedia.com/wsapi/rest/hotel/v1/search").
        to_return(:status => 200, :body => [], :headers => {})
      assert_equal 0, ExpediaApi::Client.new.get_list.entries.length
    end
    it "includes an exception if one is risen" do
      stub_request(:any, "https://ews.expedia.com/wsapi/rest/hotel/v1/search").to_raise(Faraday::ConnectionFailed)
      assert_equal true, ExpediaApi::Client.new.get_list.error?
      assert ExpediaApi::Client.new.get_list.exception
    end
    it "returns data for one item in the response" do
      stub_request(:any, "https://ews.expedia.com/wsapi/rest/hotel/v1/search").
        to_return(:status => 200, :body => ResponseMocks.one_entry, :headers => {})
      assert_equal Array, ExpediaApi::Client.new.get_list.entries.class
      assert_equal 1, ExpediaApi::Client.new.get_list.entries.length
    end
    it "returns data for two items in the response" do
      stub_request(:any, "https://ews.expedia.com/wsapi/rest/hotel/v1/search").
        to_return(:status => 200, :body => ResponseMocks.two_entries, :headers => {})
      assert_equal Array, ExpediaApi::Client.new.get_list.entries.class
      assert_equal 2, ExpediaApi::Client.new.get_list.entries.length
    end
  end
end
