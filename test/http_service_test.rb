require 'test_helper'

describe ExpediaApi::HTTPService do
  describe "server_url" do
    it "it returns a URL" do
      assert ExpediaApi::HTTPService.server_url.length > 0
    end
  end

  describe "common_parameters" do
    it "it returns a hash with default parameters" do
      assert_equal Hash, ExpediaApi::HTTPService.common_parameters.class
    end
  end

  describe "faraday_options" do
    it "returns a hash with options" do
      assert_equal Hash, ExpediaApi::HTTPService.faraday_options.class
    end
  end

  describe "proxy_options" do
    it "returns a hash with options" do
      ExpediaApi.proxy_uri      = "1"
      ExpediaApi.proxy_user     = "2"
      ExpediaApi.proxy_password = "3"
      options = ExpediaApi::HTTPService.proxy_options
      assert_equal ExpediaApi.proxy_uri, options[:uri]
      assert_equal ExpediaApi.proxy_user, options[:user]
      assert_equal ExpediaApi.proxy_password, options[:password]
    end
  end

  describe "use_proxy?" do
    it "returns true if proxy credentials are set" do
      ExpediaApi.proxy_uri      = "test"
      ExpediaApi.proxy_user     = "test"
      ExpediaApi.proxy_password = "test"
      assert_equal true, ExpediaApi::HTTPService.use_proxy?
    end
    it "returns false if proxy credentials are missing" do
      ExpediaApi.proxy_uri      = false
      ExpediaApi.proxy_user     = false
      ExpediaApi.proxy_password = false
      assert_equal false, ExpediaApi::HTTPService.use_proxy?
    end
  end
end
