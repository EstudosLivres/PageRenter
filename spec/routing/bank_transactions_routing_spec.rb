require "spec_helper"

describe BankTransactionsController do
  describe "routing" do

    it "routes to #index" do
      get("/bank_transactions").should route_to("bank_transactions#index")
    end

    it "routes to #new" do
      get("/bank_transactions/new").should route_to("bank_transactions#new")
    end

    it "routes to #show" do
      get("/bank_transactions/1").should route_to("bank_transactions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/bank_transactions/1/edit").should route_to("bank_transactions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/bank_transactions").should route_to("bank_transactions#create")
    end

    it "routes to #update" do
      put("/bank_transactions/1").should route_to("bank_transactions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/bank_transactions/1").should route_to("bank_transactions#destroy", :id => "1")
    end

  end
end
