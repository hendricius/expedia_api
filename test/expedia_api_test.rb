require 'test_helper'

describe ExpediaApi do
  describe "version" do
    it "has a version" do
      refute_nil ::ExpediaApi::VERSION
    end
  end
  describe "api_key=" do
    it "allows setting an API key" do
      ExpediaApi.api_key = "test"
      assert_equal "test", ExpediaApi.api_key
    end
  end
end
