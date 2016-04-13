require 'test_helper'

describe ExpediaApi::Entities::PackageEntity do
  let(:api_data) { ResponseMocks.package_search_one_hotel.with_indifferent_access }
  let(:entity) { ExpediaApi::Entities::PackageEntity.new(api_data)}

  describe "#initialize" do
    it "creates a new package entity object" do
      assert_equal ExpediaApi::Entities::PackageEntity, ExpediaApi::Entities::PackageEntity.new(api_data).class
    end
  end


end
