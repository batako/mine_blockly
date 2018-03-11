require "rails_helper"

RSpec.describe Blocklies::WorkspacesController, type: :routing do
  describe "routing" do

    it "routes to #new" do
      expect(get: "/blocklies/workspaces/new").to route_to("blocklies/workspaces#new")
    end

    it "routes to #edit" do
      expect(get: "/blocklies/workspaces/1/edit").to route_to("blocklies/workspaces#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/blocklies/workspaces").to route_to("blocklies/workspaces#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/blocklies/workspaces/1").to route_to("blocklies/workspaces#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/blocklies/workspaces/1").to route_to("blocklies/workspaces#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/blocklies/workspaces/1").to route_to("blocklies/workspaces#destroy", id: "1")
    end

  end
end
