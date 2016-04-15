require 'json'
require 'faraday'
require 'faraday_middleware'
require 'active_support/core_ext/hash/indifferent_access'

require "expedia_api/version"
require "expedia_api/http_service"
require "expedia_api/client"
require "expedia_api/entities"
require "expedia_api/entities/search_entity"
require "expedia_api/entities/package_entity"
require "expedia_api/entities/package_flight"
require "expedia_api/entities/package_hotel"
require "expedia_api/response_lists"
require "expedia_api/response_lists/base_response_list"
require "expedia_api/response_lists/packages"
require "expedia_api/response_lists/hotels"

module ExpediaApi
  class << self
    attr_accessor :api_key, :proxy_uri, :proxy_password, :proxy_user
  end
end
