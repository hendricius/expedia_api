module ExpediaApi
  class HotelResponseList
    include Enumerable
    attr_reader :response, :exception

    def initialize(members: [], response: nil, exception: nil)
      @members = members
      @response = response
      @exception = exception
    end

    def each(&block)
      @memebers.each(&:block)
    end

    def map(&block)
      @memebers.map(&:block)
    end

    def raw_data
      @members
    end

    def success?
      exception.nil?
    end

    def error?
      !!exception
    end
  end
end

