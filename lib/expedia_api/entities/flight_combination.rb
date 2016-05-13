module ExpediaApi
  module Entities
    class FlightCombination
      attr_accessor :outbound_leg, :return_leg, :cheapest_combination_price
      attr_reader :raw_data

      def initialize(raw_data)
        @raw_data = raw_data || {}
      end

      def piid
        @raw_data[:PIID]
      end

      #returns a money object including the price. returns nil if there is no price
      def total_price
        if raw_data[:PriceInformation] && raw_data[:PriceInformation][:TotalPrice]
          Money.new(raw_data[:PriceInformation][:TotalPrice][:Value].to_f * 100, raw_data[:PriceInformation][:TotalPrice][:CurrencyCode])
        else
          nil
        end
      end

      def price_difference_to_cheapest_combination
        return nil unless total_price && cheapest_combination_price
        total_price - Money.new(cheapest_combination_price[:Value].to_f * 100, cheapest_combination_price[:CurrencyCode])
      end

    end
  end
end
