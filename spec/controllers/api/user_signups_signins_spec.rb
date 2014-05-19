require 'spec_helper'

describe "User Registration & LogIn" do
  subject(:http_helper) { API::Concerns::HttpTestHelper.new }
  subject(:empty_user) { {'user' => ''} }
  subject(:valid_user) { {'user' => {role: 'publisher', locale: 'pt', name: 'Ilton Garcia', nick: '', email: '', password: ''}} }
  subject(:invalid_user) { {'user' => {role: '', locale: '', name: '', nick: '', email: '', password: ''}} }

  before(:each) do
    @controller = API::UsersController
  end

  # Submit an user empty hash as param for SignUp_SignIn
  describe "SignUp user BY #INVALID user FORM" do
    subject(:invalid_form_resp) { http_helper.post('/system/signup_signin', empty_user) }

    it "Should be accessible" do invalid_form_resp.code.to_i.should == 200 end
    it "Should has an error" do JSON.parse(invalid_form_resp.body)['status'].should == 'error' end
    it "Should has an message" do JSON.parse(invalid_form_resp.body).should have_key('msg') end
  end

  it "SigIn user BY SocialSession JSON" do

  end
end
