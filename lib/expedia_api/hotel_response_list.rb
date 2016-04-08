module ExpediaApi
  class HotelResponseList
    include Enumerable
    attr_reader :response, :exception

    def initialize(entries: [], response: nil, exception: nil)
      @response = response
      self.entries = extract_entries_from_response(response)
      @exception = exception
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
      @entries = entries.map {|e| ExpediaApi::Entities::SearchEntity.new(e.with_indifferent_access) }
    end

    def success?
      exception.nil?
    end

    def error?
      !!exception
    end

    def response_body
    end

    def extract_entries_from_response(response)
      # probably an error ocurred connecting
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
