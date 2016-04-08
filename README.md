# Expedia Api

This is a ruby wrapper for the official Expedia.com API. Please note that the Expedia.com API is a different than the one provided by the Expedia Affiliate Network. They are different companies. If you want to use the EAN Api please use [expedia gem](https://github.com/zaidakram/expedia).


## Installation

Add this line to your application's Gemfile:

```
gem 'expedia_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install expedia_api

## Usage

Create an initializer that sets your API key:

```
config/initializers/expedia_api.rb

````

Set the API key:

```
Expedia.api_key = 'my_api_key'

```

Then when using the API create a new client object:

```
client = ExpediaApi::Client.new
client.get_list({})


```

The parameters you can pass to `get_list` are the following:

```
location:
  example:
    40.714269,-74.005973
  description:
    The composition of latitude and longitude values
    identifying the center point of a hotel search radius (circle). The
    latitude and longitude values are joined together with a comma (,)
    character.
  remark:
    When this parameter is used, the RADIUS parameter is required.
radius:
  example:
    10km
  description:
    The size of the hotel search radius around the specified latitude
    and longitude, along with its associated unit of measure.
    The units default to kilometers if a value isn't provided in the composition.
    Valid units are KM and MI.
  remark:
    Radius must be less than 200.0km/124.30081 miles. The radius only
    applies to the LOCATION parameter.
hotelids:
  example:
    28082, 11133
  description:
    Comma-separated list of Hotel IDs for which to return results.
regionids:
  example:
    8816, 1234
  description:
    Comma-separated list of Expedia Region IDs. Searching is done for
    all hotels in the regions.
dates:
  example:
    2011-01-19,2011-01-20
  description:
    Comma separated list of check- in/check-out dates for hotel stay
    in an ISO 8601 Date format [YYYY-MM-DD]. If this parameter is not
    included, a dateless search will be conducted which returns a
    featured offer for each of the hotels found.
  remark:
    Max advance search window is 330 days.
language:
  example:
    en-US
  description:
    language is composed of language code and country code, connected by
    "-". Must be a valid language for the Point of Sale. For example,
    "fr-FR"/"fr- CA" is a valid language for France/Canada site, but
    could not be "fr-US". If no language is specified, a default
    language will be used.
currency:
  example:
    USD
  description:
    Value should be a standard ISO. 3 letter currency code, e.g. CAD -
    Canadian dollar, USD - US dollar
    If not specified for dated searches, USD will be returned.
    If not specified for dateless searches, the pos native currency
    will be returned.
adults:
  example:
    2,1
  description:
    Comma-separated list that specifies the number of adults staying in
    each of the rooms to be requested.
  remark:
    Default value will be 2 if not specified. It indicates only one room
    is required and there are two adults staying in the room. Up to 8
    rooms can be requested at a time.
    Example:
    adults=2,2,2,2 (four rooms with two adults in each room))
availonly:
  example:
    true
  description:
    return available hotels only. default: true

    
```

Please refer to the official API documentation by the Expedia.com team for more parameters.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on.
