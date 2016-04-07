class ResponseMocks
  def self.two_entries
    {
        "HotelCount": "2",
        "HotelInfoList": {
            "HotelInfo": [
                {
                    "AmenityList": {
                        "Amenity": "High-speed Internet"
                    },
                    "Description": "Dieses Apartmenthotel f\u00fcr Familien in Hamburg ist dank der hervorragenden Lage (Neustadt) zu Fu\u00df nur 15 Minuten entfernt von: St.-Michaelis-Kirche und Hamburger Rathaus. Ebenfalls nur 3 km entfernt: M\u00f6nckebergstra\u00dfe und Hamburger Kunsthalle. ",
                    "DetailsUrl": "http://www.expedia.de/go/hotel/info/8757023/2016-05-01/2016-05-10?NumRooms=1&NumAdult-Room1=1&tpid=6&eapid=15070&langid=1031",
                    "GuestRating": "4.5",
                    "GuestReviewCount": "206",
                    "HotelID": "8757023",
                    "Location": {
                        "City": "Hamburg",
                        "Country": "DEU",
                        "GeoLocation": {
                            "Latitude": "53.548882",
                            "Longitude": "9.980805"
                        },
                        "Province": "HH",
                        "StreetAddress": "Ludwig-Erhard-Strasse 7"
                    },
                    "Name": "Citadines Michel Hamburg",
                    "StarRating": "4.0",
                    "StatusCode": "1",
                    "ThumbnailUrl": "https://images.trvl-media.com/hotels/9000000/8760000/8757100/8757023/8757023_15_t.jpg"
                },
                {
                    "AmenityList": {
                        "Amenity": [
                            "Swimming pool",
                            "High-speed Internet"
                        ]
                    },
                    "Description": "Dieses Apartmenthotel f\u00fcr Familien in Dubai liegt im Gesch\u00e4ftsviertel, zu Fu\u00df nur 15 Minuten entfernt von: Ski Dubai und Mall of the Emirates. Ebenfalls nur 5 km entfernt: Souk Madinat und Jebel Ali Race Course. ",
                    "DetailsUrl": "http://www.expedia.de/go/hotel/info/3482297/2016-05-01/2016-05-10?NumRooms=1&NumAdult-Room1=1&tpid=6&eapid=15070&langid=1031",
                    "GuestRating": "4.4",
                    "GuestReviewCount": "191",
                    "HotelID": "3482297",
                    "HotelMandatoryTaxesAndFees": {
                        "Currency": "EUR",
                        "Value": "21.50"
                    },
                    "Location": {
                        "City": "Dubai",
                        "Country": "ARE",
                        "GeoLocation": {
                            "Latitude": "25.112887",
                            "Longitude": "55.194795"
                        },
                        "Province": "",
                        "StreetAddress": "Road 329, Al Barsha 1"
                    },
                    "Name": "Centro Barsha",
                    "Price": {
                        "BaseRate": {
                            "Currency": "EUR",
                            "Value": "472.95"
                        },
                        "TaxRcAndFees": {
                            "Currency": "EUR",
                            "Value": "94.59"
                        },
                        "TotalRate": {
                            "Currency": "EUR",
                            "Value": "567.54"
                        }
                    },
                    "Promotion": {
                        "Amount": {
                            "Currency": "EUR",
                            "Value": "118.26"
                        },
                        "Description": "Fr\u00fch buchen und 20% sparen"
                    },
                    "RoomTypeList": {
                        "RoomType": {
                            "Description": "Classic-Zimmer, 1 Queen-Bett",
                            "FreeCancellation": "false",
                            "HotelMandatoryTaxesAndFees": {
                                "Currency": "EUR",
                                "Value": "21.50"
                            },
                            "PaymentMethod": "Online",
                            "Price": {
                                "BaseRate": {
                                    "Currency": "EUR",
                                    "Value": "472.95"
                                },
                                "TaxRcAndFees": {
                                    "Currency": "EUR",
                                    "Value": "94.59"
                                },
                                "TotalRate": {
                                    "Currency": "EUR",
                                    "Value": "567.54"
                                }
                            },
                            "Promotion": {
                                "Amount": {
                                    "Currency": "EUR",
                                    "Value": "118.26"
                                },
                                "Description": "Fr\u00fch buchen und 20% sparen"
                            },
                            "Refundable": "false",
                            "SmokingAvailable": {
                                "HasNonSmoking": "true",
                                "HasSmoking": "true"
                            }
                        }
                    },
                    "StarRating": "3.0",
                    "StatusCode": "0",
                    "ThumbnailUrl": "https://images.trvl-media.com/hotels/4000000/3490000/3482300/3482297/3482297_112_t.jpg"
                }
            ]
        },
        "MatchingHotelCount": "2",
        "StayDates": {
            "CheckInDate": "2016-05-01",
            "CheckOutDate": "2016-05-10"
        }
    }.to_json
  end

  def self.one_entry
    {
      "HotelCount": "1",
      "HotelInfoList": {
        "HotelInfo": {
          "AmenityList": {
            "Amenity": [
              "Swimming pool",
              "High-speed Internet"
            ]
          },
          "Description": "Dieses Apartmenthotel f\u00fcr Familien in Dubai liegt im Gesch\u00e4ftsviertel, zu Fu\u00df nur 15 Minuten entfernt von: Ski Dubai und Mall of the Emirates. Ebenfalls nur 5 km entfernt: Souk Madinat und Jebel Ali Race Course. ",
          "DetailsUrl": "http://www.expedia.de/go/hotel/info/3482297/2016-05-01/2016-05-10?NumRooms=1&NumAdult-Room1=1&tpid=6&eapid=15070&langid=1031",
          "GuestRating": "4.4",
          "GuestReviewCount": "191",
          "HotelID": "3482297",
          "HotelMandatoryTaxesAndFees": {
            "Currency": "EUR",
            "Value": "21.50"
          },
          "Location": {
            "City": "Dubai",
            "Country": "ARE",
            "GeoLocation": {
              "Latitude": "25.112887",
              "Longitude": "55.194795"
            },
            "Province": "",
            "StreetAddress": "Road 329, Al Barsha 1"
          },
          "Name": "Centro Barsha",
          "Price": {
            "BaseRate": {
              "Currency": "EUR",
              "Value": "472.95"
            },
            "TaxRcAndFees": {
              "Currency": "EUR",
              "Value": "94.59"
            },
            "TotalRate": {
              "Currency": "EUR",
              "Value": "567.54"
            }
          },
          "Promotion": {
            "Amount": {
              "Currency": "EUR",
              "Value": "118.26"
            },
            "Description": "Fr\u00fch buchen und 20% sparen"
          },
          "RoomTypeList": {
            "RoomType": {
              "Description": "Classic-Zimmer, 1 Queen-Bett",
              "FreeCancellation": "false",
              "HotelMandatoryTaxesAndFees": {
                "Currency": "EUR",
                "Value": "21.50"
              },
              "PaymentMethod": "Online",
              "Price": {
                "BaseRate": {
                  "Currency": "EUR",
                  "Value": "472.95"
                },
                "TaxRcAndFees": {
                  "Currency": "EUR",
                  "Value": "94.59"
                },
                "TotalRate": {
                  "Currency": "EUR",
                  "Value": "567.54"
                }
              },
              "Promotion": {
                "Amount": {
                  "Currency": "EUR",
                  "Value": "118.26"
                },
                "Description": "Fr\u00fch buchen und 20% sparen"
              },
              "Refundable": "false",
              "SmokingAvailable": {
                "HasNonSmoking": "true",
                "HasSmoking": "true"
              }
            }
          },
          "StarRating": "3.0",
          "StatusCode": "0",
          "ThumbnailUrl": "https://images.trvl-media.com/hotels/4000000/3490000/3482300/3482297/3482297_112_t.jpg"
        }
      },
      "MatchingHotelCount": "1",
      "StayDates": {
        "CheckInDate": "2016-05-01",
        "CheckOutDate": "2016-05-10"
      }
    }.to_json
  end
end
