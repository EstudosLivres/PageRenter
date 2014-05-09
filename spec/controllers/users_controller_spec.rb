require 'spec_helper'

describe UsersController do

  describe "GET 'sign_out'" do
    it "returns http success" do
      get 'sign_out'
      response.should be_success
    end
  end

end
