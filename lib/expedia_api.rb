require 'json'
require 'faraday'
require 'faraday_middleware'
require 'active_support/core_ext/hash/indifferent_access'
require 'money'

require "expedia_api/version"
require "expedia_api/http_service"
require "expedia_api/client"
require "expedia_api/entities"
require "expedia_api/entities/search_entity"
require "expedia_api/entities/package"
require "expedia_api/entities/package_flight"
require "expedia_api/entities/package_flight_leg"
require "expedia_api/entities/package_flight_leg_segment"
require "expedia_api/entities/package_hotel"
require "expedia_api/entities/flight_combination"
require "expedia_api/entities/flight_combination_leg"
require "expedia_api/entities/flight_combination_leg_segment"
require "expedia_api/response_lists"
require "expedia_api/response_lists/base_response_list"
require "expedia_api/response_lists/packages"
require "expedia_api/response_lists/hotels"
require "expedia_api/response_lists/flights"

module ExpediaApi
  class << self
    attr_accessor :api_key, :proxy_uri, :proxy_password, :proxy_user
  end
end
