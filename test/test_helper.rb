$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'expedia_api'

require 'minitest/spec'
require 'minitest/autorun'
require 'webmock/minitest'
require 'pry'

ExpediaApi.api_key = "test"
