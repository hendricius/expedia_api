module ExpediaApi
  module ResponseLists
    class BaseResponseList
      include Enumerable
      attr_reader :response, :exception

      def initialize(entries: [], response: nil, exception: nil)
        @response    = response
        self.entries = extract_entries_from_response(response)
        @exception   = exception
      end

      def each(&block)
        @entries.each(&:block)
      end

      def map(&block)
        @entries.map(&:block)
      end

      def first
        @entries.first
      end

      def last
        @entries.last
      end

      def entries
        @entries
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

    end
  end
end
