require 'spec_helper'
require 'its'
include API

describe API::UsersController do
  subject(:controller) { API::UsersController.new }
  subject(:empty_user) { {'user' => ''} }
  subject(:invalid_user) { {'user' => {role: '', locale: '', name: '', nick: '', email: '', password: ''}.to_json} }
  subject(:valid_user) { {'user' => {role: 'publisher', locale: 'pt', name: 'Ilton Garcia', nick: 'ton', email: '11@1.1', password: '123'}.to_json} }
  subject(:invalid_fb_user) { {'user' => { 'social_session' =>
                                       {
                                           'login' => {
                                               'count_friends' => '423', 'id' => '100001939359300', 'locale' => 'pt_BR', 'name' => 'Ilton Garcia', 'network_id' => 1, 'username' => 'ilton.garcia'
                                           },
                                           'pages' => {
                                               'data' => [
                                                   {
                                                       'access_token' => 'CAADRLUro74ABAMwTepZCYppffNLXXJvp0aIhxIcVzLIdOZCbU4v3ZClc2xxZBGZB1tVcGYo9nlxWZBMKzfJarBC2sslXRxkwap2ZCZCW6crVn9ZA0QcZAoXPzwwFoHBBKoUswiQxp50ZB5FouUutmR0oYKnZCiAVVuuNF84ZCwAdKNCg69fRs9oSBokENNZCt0LaL2AMUZD',
                                                       'category' => 'Community',
                                                       'id' => '211020152393246',
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
  }} }
  subject(:valid_fb_user) { {'user' => { 'social_session' =>
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
  }} }

  # Submit an empty user hash as param for SignUp_SignIn
  describe "SignUp #EMPTY user BY FORM" do
    before { post :system_signup_signin, empty_user }
    subject(:resp_body) { JSON.parse(response.body) }

    it "Should be accessible" do response.should be_success end
    it "Should has an error" do
      resp_body['status'].should == 'error' end
    it "Should has an message" do resp_body.should have_key('msg') end
    it "Message should respond per invalid attribute" do resp_body['msg'].should be_a String end
    it "Should be #:no_user_data type message" do resp_body['type'].should == 'no_user_data' end
  end

  # Submit an invalid user hash as param for SignUp_SignIn
  describe "SignUp #INVALID user BY FORM" do
    before { post :system_signup_signin, invalid_user }
    subject(:resp_body) { JSON.parse(response.body) }

    it "Should be accessible" do response.should be_success end
    it "Should has an error" do resp_body['status'].should == 'error' end
    it "Should has an message" do resp_body.should have_key('msg') end
    it "Message should respond per invalid attribute" do JSON.parse(resp_body['msg']).should be_a Hash end
    it "Should be #:invalid_attr_value type message" do resp_body['type'].should == 'invalid_attr_value' end
  end

  # Submit an valid user hash as param for SignUp_SignIn (Log if exists or Register if not exist)
  describe "SignUp #VALID user BY FORM" do
    before { post :system_signup_signin, valid_user }
    subject(:resp_body) { JSON.parse(response.body) }

    it "Should be accessible" do response.should be_success end
    it "Should has an error" do resp_body['status'].should == 'ok' end
    it "Should has an message" do resp_body.should have_key('msg') end
    it "Message should respond per invalid attribute" do resp_body['msg'].should be_a String end
    it "Should be #:invalid_attr_value type message" do resp_body.should_not have_key('type') end
  end

  # Facebook login
  describe "SigIn #INVALID user BY SocialSession JSON" do
    before { post :system_signup_signin, invalid_fb_user }
    subject(:resp_body) { JSON.parse(response.body) }

    it "Should be accessible" do
      response.should be_success end
    it "Should has an error message" do resp_body['status'].should == 'error' end
    it "Should be invaalid_attr_value type" do resp_body['type'].should == 'invalid_attr_value' end
    it "User should_not be registered" do  end # expect { User.all.length }.from(0).to(0)
    it "SocialSession should_not be registered" do  end
  end

  describe "SigIn #VALID user BY SocialSession JSON" do
    before { post :system_signup_signin, valid_fb_user }
    subject(:resp_body) { JSON.parse(response.body) }

    it "Should be accessible" do response.should be_success end
    it "Should be registered" do resp_body['msg'].should == 'registered' end
  end
end