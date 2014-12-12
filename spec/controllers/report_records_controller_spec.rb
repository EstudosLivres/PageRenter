require 'spec_helper'

describe ReportRecordsController do

  describe "GET 'brought_accesses'" do
    it "returns http success" do
      get 'brought_accesses'
      response.should be_success
    end
  end

  describe "GET 'campaigns'" do
    it "returns http success" do
      get 'campaigns'
      response.should be_success
    end
  end

end
