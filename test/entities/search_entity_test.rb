require 'test_helper'
require 'response_mocks'

describe ExpediaApi::Entities::SearchEntity do
  let(:api_data) { JSON.parse(ResponseMocks.one_entry)["HotelInfoList"]["HotelInfo"].with_indifferent_access }
  let(:entity) { ExpediaApi::Entities::SearchEntity.new(api_data)}

  describe "available?" do
    it "returns true if there is price data" do
      assert entity.total_price_including_taxes > 0
      assert entity.available?
      refute entity.sold_out?
      entity.raw_data[:Price] = nil
      refute entity.available?
      assert entity.sold_out?
    end
  end

  describe "raw_data" do
    it "returns the raw json data" do
      assert_equal entity.raw_data, api_data
    end
  end

  describe "total_price_including_taxes" do
    it "returns the total price if there is one in the JSON data" do
      assert_equal 589.04, entity.total_price_including_taxes
    end
    it "returns nil if there is no price in the data" do
      entity.raw_data[:Price] = {}
      assert_equal nil, entity.total_price_including_taxes
    end
  end

  describe "hotel_mandatory_taxes_and_fees" do
    it "returns the data from the json" do
      assert_equal 21.50, entity.hotel_mandatory_taxes_and_fees
    end
    it "returns nil if there is no value provided" do
      entity.raw_data[:HotelMandatoryTaxesAndFees] = {}
      assert_equal nil, entity.hotel_mandatory_taxes_and_fees
    end
  end

  describe "hotel_mandatory_taxes_and_fees_currency" do
    it "returns the data from the json" do
      assert_equal "EUR", entity.hotel_mandatory_taxes_and_fees_currency
    end
    it "returns nil if there is no value provided" do
      entity.raw_data[:HotelMandatoryTaxesAndFees] = {}
      assert_equal nil, entity.hotel_mandatory_taxes_and_fees_currency
    end
  end

  describe "currency" do
    it "returns the currency if there is one in the JSON data" do
      assert_equal "EUR", entity.currency
    end
    it "returns nil if there is no currency in the data" do
      entity.raw_data[:Price] = {}
      assert_equal nil, entity.currency
    end
  end

  describe "id" do
    it "returns the hotel id" do
      assert_equal 3482297, entity.id
    end
  end

  describe "expedia_id" do
    it "returns the hotel id" do
      assert_equal 3482297, entity.id
    end
  end

  describe "has_promotion?" do
    it "returns true if there is promotion data" do
      assert entity.has_promotion?
      entity.raw_data[:Promotion] = {}
      refute entity.has_promotion?
    end
  end

  describe "promotion_text" do
    it "returns the text of the promotion" do
      assert_equal "Book now bro", entity.promotion_text
      entity.raw_data[:Promotion] = {}
      refute entity.promotion_text
    end
  end
  describe "promotion_currency" do
    it "returns the currency of the promotion" do
      assert_equal "EUR", entity.promotion_currency
      entity.raw_data[:Promotion] = {}
      refute entity.promotion_currency
    end
  end
  describe "promotion_value" do
    it "returns the value of the promotion" do
      assert_equal 118.26, entity.promotion_value
      entity.raw_data[:Promotion] = {}
      refute entity.promotion_value
    end
  end

end
