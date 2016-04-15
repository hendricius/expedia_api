module ExpediaApi
  module Entities
    class PackageHotel
      attr_reader :raw_data

      def initialize(raw_data)
        @raw_data = raw_data || {}
      end
    end
  end
end
