require 'spec_helper'

describe "User Registration & LogIn" do
  subject(:http_helper) { API::Concerns::HttpTestHelper.new }
  subject(:empty_user) { {'user' => ''} }
  subject(:valid_user) { {'user' => {role: 'publisher', locale: 'pt', name: 'Ilton Garcia', nick: '', email: '', password: ''}.to_json} }
  subject(:invalid_user) { {'user' => {role: '', locale: '', name: '', nick: '', email: '', password: ''}.to_json} }

  before(:each) do
    @controller = API::UsersController
  end

  # Submit an empty user hash as param for SignUp_SignIn
  describe "SignUp #EMPTY user BY FORM" do
    subject(:invalid_form_resp) { http_helper.post('/system/signup_signin', empty_user) }

    it "Should be accessible" do invalid_form_resp.code.to_i.should == 200 end
    it "Should has an error" do JSON.parse(invalid_form_resp.body)['status'].should == 'error' end
    it "Should has an message" do JSON.parse(invalid_form_resp.body).should have_key('msg') end
    it "Should be #:no_user_data type message" do JSON.parse(invalid_form_resp.body)['type'].should == 'no_user_data' end
  end

  # Submit an invalid user hash as param for SignUp_SignIn
  describe "SignUp #INVALID user BY FORM" do
    subject(:invalid_form_resp) { http_helper.post('/system/signup_signin', invalid_user) }

    it "Should be accessible" do invalid_form_resp.code.to_i.should == 200 end
    it "Should has an error" do JSON.parse(invalid_form_resp.body)['status'].should == 'error' end
    it "Should has an message" do JSON.parse(invalid_form_resp.body).should have_key('msg') end
    it "Message should respond per invalid attribute" do JSON.parse(JSON.parse(invalid_form_resp.body)['msg']).should be_a Hash end
    it "Should be #:invalid_attr_value type message" do JSON.parse(invalid_form_resp.body)['type'].should == 'invalid_attr_value' end
  end

  it "SigIn user BY SocialSession JSON" do

  end
end
