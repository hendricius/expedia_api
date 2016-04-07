require 'test_helper'

describe ExpediaApi::Client do
  describe "initialize" do
    it "returns a client object" do
      assert_equal ExpediaApi::Client, ExpediaApi::Client.new.class
    end
  end

  describe "get_list" do
    it "returns a response class item" do
      assert_equal ExpediaApi::HotelResponseList, ExpediaApi::Client.new.get_list.class
    end
  end
end
