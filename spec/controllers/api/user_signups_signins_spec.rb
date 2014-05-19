require 'spec_helper'

describe "User Registration & LogIn" do
  subject(:http_helper) { API::Concerns::HttpTestHelper.new }
  before(:each) do
    @controller = API::UsersController
  end

  describe "SignUp user BY #INVALID FORM" do
    subject(:invalid_form_resp) { http_helper.post('/system/signup_signin', {'user' => ''}) }

    it "Should be accessible" do invalid_form_resp.code.to_i.should == 200 end
    it "Should has an error" do JSON.parse(invalid_form_resp.body)['status'].should == 'error' end
    it "Should has an message" do JSON.parse(invalid_form_resp.body).should have_key('msg') end
  end

  it "SigIn user BY SocialSession JSON" do

  end
end
