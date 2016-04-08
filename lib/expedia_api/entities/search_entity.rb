module ExpediaApi
  module Entities
    class SearchEntity
      attr_reader :raw_data

      def initialize(raw_data)
        @raw_data = raw_data || {}
      end

      def available?
        if raw_data[:Price]
          !!raw_data[:Price].fetch(:TotalRate, nil)
        else
          false
        end
      end

      def sold_out?
        !available?
      end

      def total_price_including_taxes
        if available?
          raw_data[:Price][:TotalRate][:Value].to_f
        else
          nil
        end
      end

      def currency
        if available?
          raw_data[:Price][:TotalRate][:Currency]
        else
          nil
        end
      end

      def id
        raw_data[:HotelID].to_i
      end

      def expedia_id
        id
      end

      def has_promotion?
        !!raw_data[:Promotion].fetch(:Amount, nil)
      end

      def promotion_text
        if has_promotion?
          raw_data[:Promotion][:Description]
        else
          nil
        end
      end

      def promotion_value
        if has_promotion?
          raw_data[:Promotion][:Amount][:Value].to_f
        else
          nil
        end
      end

      def promotion_currency
        if has_promotion?
          raw_data[:Promotion][:Amount][:Currency]
        else
          nil
        end
      end
    end
  end
end
