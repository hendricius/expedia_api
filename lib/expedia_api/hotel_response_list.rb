module ExpediaApi
  class HotelResponseList
    include Enumerable
    attr_reader :response, :exception

    def initialize(entries: [], response: nil, exception: nil)
      @entries = entries
      @response = response
      @exception = exception
    end

    def each(&block)
      @entries.each(&:block)
    end

    def map(&block)
      @mentries.map(&:block)
    end

    def raw_data
      @entries
    end

    def success?
      exception.nil?
    end

    def error?
      !!exception
    end
  end
end

