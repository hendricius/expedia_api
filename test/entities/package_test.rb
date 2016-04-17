require 'test_helper'

describe ExpediaApi::Entities::Package do
  let(:entity) { ExpediaApi::Entities::Package.new({})}

  describe "#initialize" do
    it "creates a new package entity object" do
      assert_equal ExpediaApi::Entities::Package, ExpediaApi::Entities::Package.new({}).class
    end
  end

  describe "#price" do
    it "returns a ruby money if there is a price" do
      skip
    end
    it "returns nil if there is no price" do
      skip
    end
  end

  describe "#discount" do
    it "returns a ruby money if there is a discount" do
      skip
    end
    it "returns nil if there is no discount" do
      skip
    end
  end


end
