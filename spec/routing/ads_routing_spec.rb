require "spec_helper"

describe AdsController do
  describe "routing" do

    it "routes to #index" do
      get("/advertisements").should route_to("advertisements#index")
    end

    it "routes to #new" do
      get("/advertisements/new").should route_to("advertisements#new")
    end

    it "routes to #show" do
      get("/advertisements/1").should route_to("advertisements#show", :id => "1")
    end

    it "routes to #edit" do
      get("/advertisements/1/edit").should route_to("advertisements#edit", :id => "1")
    end

    it "routes to #create" do
      post("/advertisements").should route_to("advertisements#create")
    end

    it "routes to #update" do
      put("/advertisements/1").should route_to("advertisements#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/advertisements/1").should route_to("advertisements#destroy", :id => "1")
    end

  end
end
