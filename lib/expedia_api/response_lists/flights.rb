module ExpediaApi
  module ResponseLists
    class Flights < BaseResponseList
      def entries=(entries)
        @entries = entries
      end

      def extract_entries_from_response(response)
        json = extract_data_from_response(response).with_indifferent_access
        return [] if json.empty?
        # dup?
        json = json.with_indifferent_access
        outbound_legs_json = json["AirLegListCollection"]["AirLegList"][0]["AirLeg"]
        return_legs_json   = json["AirLegListCollection"]["AirLegList"][1]["AirLeg"]
        products_json      = JSON.parse(response.response.body).with_indifferent_access[:AirProductList][:AirProduct]
        outbound_legs      = extract_legs(outbound_legs_json)
        return_legs        = extract_legs(return_legs_json)
        combinations       = extract_combinations(products_json, outbound_legs:outbound_legs, return_legs:return_legs)
        combinations
      end

      # returns legs for each of the entries
      def extract_legs(legs_json)
        legs_json.map do |json|
          ExpediaApi::Entities::FlightCombinationLeg.new(json)
        end
      end

      # returns packages for each of the json data
      def extract_combinations(products_json, outbound_legs:, return_legs:)
        # combination_pairs, [outbound_leg_id, return_leg_id, raw_data]
        combination_pairs = products_json.map do |json|
          reference_json = json[:AirLegReferenceList][:AirLegReference]
          [reference_json[0]["AirLegIndex"], reference_json[1]["AirLegIndex"], json]
        end
        outbound_legs_by_index = outbound_legs.map{|leg| [leg.index, leg]}.to_h
        return_legs_by_index   = return_legs.map{|leg| [leg.index, leg]}.to_h
        cheapest_price = cheapest_combination_price(products_json)
        combination_pairs.map do |outbound_leg_id, return_leg_id, raw_data|
          entity = ExpediaApi::Entities::FlightCombination.new(raw_data)
          entity.outbound_leg = outbound_legs_by_index[outbound_leg_id]
          entity.return_leg   = return_legs_by_index[return_leg_id]
          entity.cheapest_combination_price = cheapest_price
          entity
        end
      end

      def cheapest_combination_price(products_json)
        products_json.min{|p| p[:PriceInformation][:TotalPrice][:Value].to_f}[:PriceInformation][:TotalPrice]
      end

    end
  end
end
