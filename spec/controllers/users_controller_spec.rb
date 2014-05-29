require 'spec_helper'
require 'factory_girl_rails'

describe UsersController do
  context "POST #VALID 'login'" do
    subject!(:publisher_profile) { FactoryGirl.create(:publisher_profile) }
    it "Redirect to it role url" do
      post :login, { 'user' => { :password => '123', :email => '11@1.1' } }
      expect(response).to redirect_to('/publishers')
    end
  end

  context "POST #INVALID 'login'" do
    subject!(:publisher_profile) { FactoryGirl.create(:publisher_profile) }
    it "Redirect to it role url" do
      post :login, { 'user' => { :password => '', :email => '11@1.1' } }
      expect(response).to redirect_to(ApplicationController.land_url)
    end
  end

  context "GET #SIGNOUT" do
    it "Should delete the session" do
      session[:user_id] = 1
      session[:user_idiom] = 'pt'
      session[:urls_visited] = [{ date: '22/08/2013', advertise_id: 32 }]

      get :sign_out

      session[:user_id].should be_nil
      session[:user_idiom].should be_nil
      session[:urls_visited].should_not be_nil
      session[:urls_visited].should be_a(Array)
      expect(response).to redirect_to(ApplicationController.land_url)
    end
  end
end
