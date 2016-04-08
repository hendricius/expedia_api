require 'json'
require 'faraday'
require 'faraday_middleware'
require 'active_support/core_ext/hash/indifferent_access'

require "expedia_api/version"
require "expedia_api/http_service"
require "expedia_api/client"
require "expedia_api/hotel_response_list"
require "expedia_api/entities"
require "expedia_api/entities/search_entity"

module ExpediaApi
  class << self
    attr_accessor :api_key, :proxy_uri, :proxy_password, :proxy_user
  end
end
