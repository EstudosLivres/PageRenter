require "spec_helper"

describe BannedAdHistoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/banned_ad_histories").should route_to("banned_ad_histories#index")
    end

    it "routes to #new" do
      get("/banned_ad_histories/new").should route_to("banned_ad_histories#new")
    end

    it "routes to #show" do
      get("/banned_ad_histories/1").should route_to("banned_ad_histories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/banned_ad_histories/1/edit").should route_to("banned_ad_histories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/banned_ad_histories").should route_to("banned_ad_histories#create")
    end

    it "routes to #update" do
      put("/banned_ad_histories/1").should route_to("banned_ad_histories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/banned_ad_histories/1").should route_to("banned_ad_histories#destroy", :id => "1")
    end

  end
end
