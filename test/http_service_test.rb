require 'test_helper'

describe ExpediaApi::HTTPService do
  describe "server" do
    it "it returns a URL" do
      assert ExpediaApi::HTTPService.server.length > 0
    end
  end

  describe "common_parameters" do
    it "it returns a hash with default parameters" do
      assert_equal Hash, ExpediaApi::HTTPService.common_parameters.class
    end
  end
end
