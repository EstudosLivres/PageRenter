require 'spec_helper'

describe "User Registration & LogIn" do
  subject(:http_helper) { API::Concerns::HttpTestHelper.new }
  subject(:empty_user) { {'user' => ''} }
  subject(:valid_user) { {'user' => {role: 'publisher', locale: 'pt', name: 'Ilton Garcia', nick: 'ton', email: '11@1.1', password: '123'}.to_json} }
  subject(:invalid_user) { {'user' => {role: '', locale: '', name: '', nick: '', email: '', password: ''}.to_json} }

  before(:each) do
    @controller = API::UsersController
  end

  # Submit an empty user hash as param for SignUp_SignIn
  describe "SignUp #EMPTY user BY FORM" do
    subject(:invalid_form_resp) { http_helper.post('/system/signup_signin', empty_user) }
    subject(:form_resp_body) { JSON.parse(invalid_form_resp.body) }

    it "Should be accessible" do invalid_form_resp.code.to_i.should == 200 end
    it "Should has an error" do form_resp_body['status'].should == 'error' end
    it "Should has an message" do form_resp_body.should have_key('msg') end
    it "Message should respond per invalid attribute" do form_resp_body['msg'].should be_a String end
    it "Should be #:no_user_data type message" do form_resp_body['type'].should == 'no_user_data' end
  end

  # Submit an invalid user hash as param for SignUp_SignIn
  describe "SignUp #INVALID user BY FORM" do
    subject(:invalid_form_resp) { http_helper.post('/system/signup_signin', invalid_user) }
    subject(:form_resp_body) { JSON.parse(invalid_form_resp.body) }

    it "Should be accessible" do invalid_form_resp.code.to_i.should == 200 end
    it "Should has an error" do form_resp_body['status'].should == 'error' end
    it "Should has an message" do form_resp_body.should have_key('msg') end
    it "Message should respond per invalid attribute" do JSON.parse(form_resp_body['msg']).should be_a Hash end
    it "Should be #:invalid_attr_value type message" do form_resp_body['type'].should == 'invalid_attr_value' end
  end

  # Submit an valid user hash as param for SignUp_SignIn (Log if exists or Register if not exist)
  describe "SignUp #VALID user BY FORM" do
    subject(:valid_form_resp) { http_helper.post('/system/signup_signin', valid_user) }
    subject(:form_resp_body) { JSON.parse(valid_form_resp.body) }

    it "Should be accessible" do valid_form_resp.code.to_i.should == 200 end
    it "Should has an error" do form_resp_body['status'].should == 'ok' end
    it "Should has an message" do form_resp_body.should have_key('msg') end
    it "Message should respond per invalid attribute" do form_resp_body['msg'].should be_a String end
    it "Should be #:invalid_attr_value type message" do form_resp_body.should_not have_key('type') end
  end

  it "SigIn user BY SocialSession JSON" do

  end
end
