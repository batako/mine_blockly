require "rails_helper"

RSpec.describe BlockliesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get: "/blocklies").to route_to("blocklies#index")
    end

    it "routes to #run" do
      expect(post: "/blocklies/run").to route_to("blocklies#run")
    end

  end
end
