module ExpediaApi
  module Entities
    class FlightCombination
      attr_accessor :outbound_leg, :return_leg
      attr_reader :raw_data

      def initialize(raw_data)
        @raw_data = raw_data || {}
      end

    end
  end
end
