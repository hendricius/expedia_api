require 'json'
require 'faraday'
require 'faraday_middleware'

require "expedia_api/version"
require "expedia_api/http_service"
require "expedia_api/client"
require "expedia_api/hotel_response_list"

module ExpediaApi
  class << self
    attr_accessor :api_key
  end
end
