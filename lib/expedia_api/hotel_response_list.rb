module ExpediaApi
  class HotelResponseList
    include Enumerable
    attr_reader :response, :exception

    def initialize(entries: [], response: nil, exception: nil)
      @entries = extract_entries_from_response(response)
      @response = response
      @exception = exception
    end

    def each(&block)
      @entries.each(&:block)
    end

    def map(&block)
      @mentries.map(&:block)
    end

    def entries
      @entries
    end

    def success?
      exception.nil?
    end

    def error?
      !!exception
    end

    def extract_entries_from_response(response)
      # probably an error ocurred connecting
      if response.nil?
        return []
      end
      body = response.body
      if !body.is_a?(Hash) || body.nil?
        return []
      end
      hotel_count = body["HotelCount"].to_i
      if hotel_count == 1
        [body["HotelInfoList"]["HotelInfo"]]
      elsif hotel_count > 1
        body["HotelInfoList"]["HotelInfo"]
      else
        []
      end
    end

  end
end
