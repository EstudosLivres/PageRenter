require 'spec_helper'

describe "User Registration & LogIn" do
  subject(:http_helper) { API::Concerns::HttpTestHelper.new }
  subject(:empty_user) { {'user' => ''} }
  subject(:invalid_user) { {'user' => {role: '', locale: '', name: '', username: '', email: '', password: ''}.to_json} }
  subject(:valid_user) { {'user' => {role: 'publisher', locale: 'pt', name: 'Ilton Garcia', username: 'ton', email: '11@1.1', password: '123'}.to_json} }
  subject(:fb_user) { {'user' => { 'social_session' =>
                                       {
                                           'login' => {
                                               'count_friends' => '423', 'email' => 'ilton_junior_91@hotmail.com', 'id' => '100001939359300', 'locale' => 'pt_BR', 'name' => 'Ilton Garcia', 'network_id' => 1, 'username' => 'ilton.garcia', 'gender' => 'male'
                                           },
                                           'pages' => {
                                               'data' => [
                                                   {
                                                       'access_token' => 'CAADRLUro74ABAMwTepZCYppffNLXXJvp0aIhxIcVzLIdOZCbU4v3ZClc2xxZBGZB1tVcGYo9nlxWZBMKzfJarBC2sslXRxkwap2ZCZCW6crVn9ZA0QcZAoXPzwwFoHBBKoUswiQxp50ZB5FouUutmR0oYKnZCiAVVuuNF84ZCwAdKNCg69fRs9oSBokENNZCt0LaL2AMUZD',
                                                       'category' => 'Community',
                                                       'id' => '211020152393246',
                                                       'name' => 'The Web Wall',
                                                       'perms' => [
                                                                    'ADMINISTER',
                                                                    'EDIT_PROFILE',
                                                                    'CREATE_CONTENT',
                                                                    'MODERATE_CONTENT',
                                                                    'CREATE_ADS',
                                                                    'BASIC_ADMIN'
                                                        ]
                                                   },
                                                   {
                                                       'access_token' => 'CAADRLUro74ABAGKxeU9vKAoqxrc0xMK6XDaWib6f7pg3ZCN1c2pldn09YOZCJUmijn9EuZCSTg13cJW3evdB0ZAfLJDZBkZCZA4kS24u1wZCcL5iRU9ZCwxy2GLiqMu9bKk17htZBhpW1bRoIIqeIYMvZB1AwZApnSXZC9uc5kt4GQyCFA2OKAluvDizXhPVnoARROQ8ZD',
                                                       'category' => 'Just for fun',
                                                       'id' => '418351588290310',
                                                       'name' => 'Tah Foda',
                                                       'perms' => [
                                                           'ADMINISTER',
                                                           'EDIT_PROFILE',
                                                           'CREATE_CONTENT',
                                                           'MODERATE_CONTENT',
                                                           'CREATE_ADS',
                                                           'BASIC_ADMIN'
                                                       ]
                                                   }]
                                           }
                                       }
  }.to_json} }

  before(:each) do
    @controller = API::RemoteUsersController
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

  # Facebook login
  describe "SigIn user BY SocialSession JSON" do
    subject(:valid_fb_user) { JSON.parse(http_helper.post('/system/signup_signin', fb_user).body) }

    it "Should be accessible" do valid_fb_user['status'].should == 'ok' end
    it "Should be logged" do valid_fb_user['msg'].should == 'logged_in' end
  end
end
