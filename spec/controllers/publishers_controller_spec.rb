require 'spec_helper'

describe PublishersController do
  subject!(:publisher_profile) { FactoryGirl.create(:publisher_profile) }
  subject!(:publisher_profile_session) { session['user_id'] = publisher_profile.user.id }

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "Access without session" do
    it "should redirect to the land_url" do
      session[:user_id] = nil
      get :edit

      expect(response).to redirect_to(ApplicationController.land_url)
    end
  end

end
