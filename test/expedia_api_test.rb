require 'test_helper'

describe ExpediaApi do
  describe "version" do
    it "has a version" do
      refute_nil ::ExpediaApi::VERSION
    end
  end
end
