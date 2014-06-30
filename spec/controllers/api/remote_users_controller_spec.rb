require 'spec_helper'
require 'its'
require 'factory_girl_rails'
include API

describe API::RemoteUsersController do
  subject(:controller) { API::RemoteUsersController.new }
  subject(:role_pub_id) { Role.where(name: 'publisher').take.id }
  subject(:role_adv_id) { Role.where(name: 'advertiser').take.id }
  let!(:publisher_profile) { FactoryGirl.create(:publisher_profile) }
  let!(:advertiser_profile) { FactoryGirl.create(:advertiser_profile) }
  subject(:valid_api_pub){{ 'email' => '11@1.1', 'password' => '123' }}
  subject(:valid_api_adv){{ 'email' => '22@2.2', 'password' => '123' }}
  subject(:invalid_api_pub){{ 'email' => '44@4.4', 'password' => '321' }}
  subject(:empty_user) { {'user' => ''} }
  subject(:invalid_pub_user) { {'user' => {role: '', locale: '', name: '', nick: '', email: '', password: ''}.to_json} }
  subject(:valid_pub_user) { {'user' => {role: 'publisher', locale: 'pt', name: 'Ilton Garcia', nick: 'ton', email: '33@3.3', password: '123'}.to_json} }
  subject(:valid_adv_user) { {'user' => {role: 'advertiser', locale: 'en', name: 'PageRenter', nick: 'page', email: '55@5.5', password: '123'}.to_json} }
  subject(:invalid_fb_user) { {'user' => { 'social_session' =>
                                       {
                                           'login' => {
                                               'count_friends' => '423', 'id' => '100001939359300', 'locale' => 'pt_BR', 'name' => 'Ilton Garcia', 'network_id' => 1
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
                                                       'count_friends' => '423', 'email' => 'ilton_junior_91@hotmail.com', 'id' => '100001939359300', 'locale' => 'pt_BR', 'name' => 'Ilton Garcia', 'network_id' => 1, 'username' => 'ton.garcia', 'gender' => 'male'
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
    before { post :system_signup_signin, invalid_pub_user }
    subject(:resp_body) { JSON.parse(response.body) }

    it "Should be accessible" do response.should be_success end
    it "Should has an error" do resp_body['status'].should == 'error' end
    it "Should has an message" do resp_body.should have_key('msg') end
    it "Message should respond per invalid attribute" do JSON.parse(resp_body['msg']).should be_a Hash end
    it "Should be #:invalid_attr_value type message" do resp_body['type'].should == 'invalid_attr_value' end
  end

  # Submit a valid user hash as param for SignUp_SignIn (Log if exists or Register if not exist)
  describe "SignUp #VALID user BY FORM" do
    before { post :system_signup_signin, valid_pub_user }
    subject(:resp_body) { JSON.parse(response.body) }

    it "Should be accessible" do response.should be_success end
    it "Should has an error" do resp_body['status'].should == 'ok' end
    it "Should has an message" do resp_body.should have_key('msg') end
    it "Message should respond per invalid attribute" do resp_body['msg'].should be_a String end
    it "Should be #:invalid_attr_value type message" do resp_body.should_not have_key('type') end
    it "Should have a Publisher & an Advertiser profile" do
      profiles = User.where(email: 'pp@p.p').take!.profiles
      profiles.length.should == 2

      count_pub = 0
      count_adv = 0
      profiles.each do |profile|
        if profile.role.id == role_pub_id
          count_pub = count_pub+1
        elsif profile.role.id == role_adv_id
          count_adv = count_adv+1
        end
      end

      count_pub.should == 1
      count_adv.should == 1
    end
  end

  # Submit a valid user hash (ADV) as param for SignUp_SignIn (Log if exists or Register if not exist)
  describe "SignUp #VALID user BY FORM" do
    before { post :system_signup_signin, valid_adv_user }
    subject(:resp_body) { JSON.parse(response.body) }

    it "Should be accessible" do response.should be_success end
    it "Should has an error" do resp_body['status'].should == 'ok' end
    it "Should has an message" do resp_body.should have_key('msg') end
    it "Message should respond per invalid attribute" do resp_body['msg'].should be_a String end
    it "Should be #:invalid_attr_value type message" do resp_body.should_not have_key('type') end
    it "Should have a Publisher & an Advertiser profile" do
      profiles = User.last!.profiles.to_a
      profiles.length.should == 2

      count_pub = 0
      count_adv = 0
      profiles.each do |profile|
        if profile.role.id == role_pub_id
          count_pub = count_pub+1
        elsif profile.role.id == role_adv_id
          count_adv = count_adv+1
        end
      end

      count_pub.should == 1
      count_adv.should == 1
    end
  end

  # Facebook login
  describe "SigIn #INVALID user BY SocialSession JSON" do
    before { post :system_signup_signin, invalid_fb_user }
    subject(:resp_body) { JSON.parse(response.body) }

    it "Should be accessible" do response.should be_success end
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

  # Mob Login
  describe "API Mob" do
    context "Login/SignUp valid user" do
      before { post :mob_login, valid_api_pub }
      subject(:valid_resp_hash) { JSON.parse(response.body) }

      it "Should be accessible" do response.should be_success end
      it "Should have an access_token now" do valid_resp_hash['access_token'].length.should > 0 end
    end

    context "Login without SignUp #VALID user" do
      before { post :mob_login, valid_api_pub }
      subject(:valid_resp_hash) { JSON.parse(response.body) }
      subject(:request_api_mob_user) { post :mob_login, { 'access_token' => valid_resp_hash['access_token']} }
      subject(:api_mob_user) { JSON.parse(request_api_mob_user.body) }
      subject(:users_access) { User.where(access_token: valid_resp_hash['access_token']).take!.access_token }


      it "Should be accessible" do response.should be_success end
      it "Should not persist" do users_access.should == User.find(publisher_profile.user.id).access_token end
      it "Should be a full user" do User.new(api_mob_user).is_a?(User).should be_true end
    end

    context "Login/SignUp #INVALID user" do
      before { post :mob_login, invalid_api_pub }
      subject(:invalid_resp_hash) { JSON.parse(response.body) }

      it "Should be accessible" do response.should be_success end
      it "Should respond with a message" do invalid_resp_hash.should have_key('erro') end
    end

    context "API Login without SignUp" do
      before { post :system_signup_signin, {'user' => valid_api_pub} }
      subject(:resp_hash) { JSON.parse(response.body) }
      it "Should respond with a logged_in message" do resp_hash['msg'].should == 'logged_in' end
    end
  end
end
