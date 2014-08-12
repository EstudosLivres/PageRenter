require 'spec_helper'

describe SocialsController do

  describe "GET 'auth'" do
    it "returns http success" do
      get 'auth'
      response.should be_success
    end
  end

end
