require 'test_helper'

describe ExpediaApi::Entities::Package do
  let(:sample_json_entity) do
    {
      "BrandedDealsMarker": {
        "BrandedDealsType": [
          "FreeOneNightHotel",
          "HotelSavingsFreeNights"
        ]
      },
      "DetailsUrl": "http://www.expedia.de/pubspec/scripts/eap.asp?GOTO=UDP&piid=ba28356e-ee46-476c-a52c-68f82d135680-0&nRooms=1&nAdults=R1:2&departTLA=L1:HAM|L2:SYD&arrivalTLA=L1:SYD|L2:HAM&departDate=L1:2016-09-07|L2:2016-09-15&tripType=roundtrip&productType=package&serviceVersion=3&destinationId=178138&price=3103.66&currencyCode=EUR",
      "FlightReferenceIndex": "1",
      "HotelReferenceIndex": "1",
      "PackagePrice": {
        "TotalPrice": {
          "Currency": "EUR",
          "Value": "3103.66"
        },
        "TotalSavings": {
          "Currency": "EUR",
          "Value": "279.89"
        }
      }
    }.with_indifferent_access
  end
  let(:entity) { ExpediaApi::Entities::Package.new(sample_json_entity) }

  describe "#initialize" do
    it "creates a new package entity object" do
      assert_equal ExpediaApi::Entities::Package, ExpediaApi::Entities::Package.new({}).class
    end
  end

  describe "#price" do
    it "returns a ruby money if there is a price" do
      assert_equal ::Money, entity.price.class
      assert_equal 3103.66, entity.price.to_f
      assert_equal "EUR", entity.price.currency
      entity.raw_data[:PackagePrice][:TotalPrice][:Currency] = "USD"
      assert_equal "USD", entity.price.currency
    end
    it "returns nil if there is no price" do
      entity.raw_data[:PackagePrice][:TotalPrice] = nil
      assert_equal nil, entity.price
      entity.raw_data[:PackagePrice] = nil
      assert_equal nil, entity.price
    end
  end

  describe "#discount" do
    it "returns a ruby money if there is a discount" do
      assert_equal ::Money, entity.savings.class
      assert_equal 279.89, entity.savings.to_f
      assert_equal "EUR", entity.savings.currency
      entity.raw_data[:PackagePrice][:TotalSavings][:Currency] = "USD"
      assert_equal "USD", entity.savings.currency
    end
    it "returns nil if there is no discount" do
      entity.raw_data[:PackagePrice][:TotalSavings] = nil
      assert_equal nil, entity.savings
      entity.raw_data[:PackagePrice] = nil
      assert_equal nil, entity.savings
    end
  end

  describe "#details_url" do
    it "returns a url if there is one present" do
      entity.raw_data[:DetailsUrl] = "http://foo"
      assert_equal "http://foo", entity.details_url
    end
  end


end
