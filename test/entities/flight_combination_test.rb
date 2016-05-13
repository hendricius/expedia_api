require 'test_helper'

describe ExpediaApi::Entities::FlightCombination do
  let(:sample_json_entity) do
    {
      "AirLegReferenceList":{
        "AirLegReference":[
          {
            "AirLegIndex":3,
            "AirLegListIndex":1,
            "BookingSegmentList":{
              "BookingSegment":[
                {
                  "AirSegmentIndex":1,
                  "BookingClass":"Coach",
                  "BookingCode":" K"
                },
                {
                  "AirSegmentIndex":2,
                  "BookingClass":"Coach",
                  "BookingCode":" H"
                },
                {
                  "AirSegmentIndex":3,
                  "BookingClass":"Coach",
                  "BookingCode":" Y"
                }
              ]
            }
          },
          {
            "AirLegIndex":8,
            "AirLegListIndex":2,
            "BookingSegmentList":{
              "BookingSegment":[
                {
                  "AirSegmentIndex":1,
                  "BookingClass":"Coach",
                  "BookingCode":" Y"
                },
                {
                  "AirSegmentIndex":2,
                  "BookingClass":"Coach",
                  "BookingCode":" H"
                },
                {
                  "AirSegmentIndex":3,
                  "BookingClass":"Coach",
                  "BookingCode":" K"
                }
              ]
            }
          }
        ]
      },
      "AirProductIndex":12,
      "CategoryCode":0,
      "CategoryCodeList":{
        "CategoryCode":[
          0
        ]
      },
      "DetailsURL":"http://www.expedia.de/pubspec/scripts/eap.asp?GOTO=UDP&piid=v5-c6b1e020462bfe3cd4d294a30df310ae-2-7-1&price=2968.74&currencyCode=EUR&departTLA=L1:TXL|L2:BOB&arrivalTLA=L1:BOB|L2:TXL&departDate=L1:2016-09-07|L2:2016-09-15&nAdults=1&nSeniors=0&nChildren=0&infantInLap=N&class=coach&sort=Price&tripType=RoundTrip&productType=air&eapid=15070-6&serviceVersion=V5&messageGuid=e3c335d8-4091-4889-88ac-d726005e4912&langid=1031",
      "OpaqueFlight":false,
      "PIID":"v5-c6b1e020462bfe3cd4d294a30df310ae-2-7-1",
      "PriceInformation":{
        "PassengerDetailsList":{
          "PassengerDetails":[
            {
              "PassengerCode":"Adult",
              "PassengerCount":1,
              "PerPersonPrice":{
                "CurrencyCode":"EUR",
                "Value":"2124.00"
              }
            }
          ]
        },
        "TotalBookingFees":{
          "CurrencyCode":"EUR",
          "Value":"0.00"
        },
        "TotalPrice":{
          "CurrencyCode":"EUR",
          "Value":"2968.74"
        },
        "TotalTaxesAndFees":{
          "CurrencyCode":"EUR",
          "Value":"844.74"
        }
      },
      "SplitTicket":false
    }.with_indifferent_access
  end
  let(:entity) { ExpediaApi::Entities::FlightCombination.new(sample_json_entity) }

  describe "#initialize" do
    it "creates a new combination entity object" do
      assert_equal ExpediaApi::Entities::FlightCombination, ExpediaApi::Entities::FlightCombination.new({}).class
    end
  end

  describe "#piid" do
    it "returns the PIID" do
      assert_equal "v5-c6b1e020462bfe3cd4d294a30df310ae-2-7-1", entity.piid
    end
  end

  describe "#total_price" do
    it "returns a ruby money if there is a price" do
      assert_equal "EUR", entity.total_price.currency
      assert_equal ::Money, entity.total_price.class
      assert_equal 2968.74, entity.total_price.to_f
      assert_equal "EUR", entity.total_price.currency.to_s
    end
    it "returns nil if there is no price" do
      entity.raw_data[:PriceInformation][:TotalPrice] = nil
      assert_equal nil, entity.total_price
      entity.raw_data[:PriceInformation] = nil
      assert_equal nil, entity.total_price
    end
  end

  describe "price_difference_to_cheapest_combination" do
    it "returns the different between the total price and the cheapest" do
      entity.raw_data[:PriceInformation]["TotalPrice"] = {"CurrencyCode"=>"EUR", "Value"=>"100.0"}.with_indifferent_access
      entity.cheapest_combination_price = {"CurrencyCode"=>"EUR", "Value"=>"60.0"}.with_indifferent_access
      difference = entity.price_difference_to_cheapest_combination
      assert_equal ::Money, difference.class
      assert_equal 40.0, difference.to_f
      assert_equal "EUR", difference.currency.to_s
    end
    it "returns nil if there is no total price" do
      def entity.price; nil; end
      assert_equal nil, entity.price_difference_to_cheapest_combination
    end
    it "returns nil if there is no cheapest price" do
      def cheapest_combination_price; nil; end
      assert_equal nil, entity.price_difference_to_cheapest_combination
    end
  end

end
