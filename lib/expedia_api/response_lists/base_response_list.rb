module ExpediaApi
  module ResponseLists
    class BaseResponseList
      include Enumerable
      attr_reader :response, :exception

      def initialize(entries: [], response: nil, exception: nil)
        @response    = response
        @exception   = exception
      end

      def each(&block)
        entries.each(&:block)
      end

      def map(&block)
        entries.map(&:block)
      end

      def first
        entries.first
      end

      def last
        entries.last
      end

      def entries
        @entries ||= begin
          self.entries = extract_entries_from_response(@response)
          self.entries
        end
      end

      def entries=(entries)
        raise ArgumentError, "implement me"
      end

      def success?
        exception.nil?
      end

      def error?
        !!exception
      end

      def extract_entries_from_response(response)
        raise ArgumentError, "implement me"
      end

      private

      # extracts an array of data from the response
      #
      # returns an array.
      def extract_data_from_response(response)
        if response.nil?
          return []
        end
        body = nil
        begin
          body = JSON.parse(response.body)
        rescue JSON::ParserError => e
          @exception = e
          return []
        end
        if !body.is_a?(Hash) || body.nil?
          return []
        end
        body
      end

    end
  end
end
