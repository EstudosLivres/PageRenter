require 'spec_helper'

describe ErrorsController do

  describe "GET 'catch_404'" do
    it "returns http success" do
      get 'catch_404'
      response.should be_success
    end
  end

end
