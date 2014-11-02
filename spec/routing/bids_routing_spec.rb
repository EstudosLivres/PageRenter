require "spec_helper"

describe BidsController do
  describe "routing" do

    it "routes to #index" do
      get("/bids").should route_to("bids#index")
    end

    it "routes to #new" do
      get("/bids/new").should route_to("bids#new")
    end

    it "routes to #show" do
      get("/bids/1").should route_to("bids#show", :id => "1")
    end

    it "routes to #edit" do
      get("/bids/1/edit").should route_to("bids#edit", :id => "1")
    end

    it "routes to #create" do
      post("/bids").should route_to("bids#create")
    end

    it "routes to #update" do
      put("/bids/1").should route_to("bids#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/bids/1").should route_to("bids#destroy", :id => "1")
    end

  end
end
