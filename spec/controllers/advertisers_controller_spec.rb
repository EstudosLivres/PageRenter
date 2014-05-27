require 'spec_helper'

describe AdvertisersController do
  subject!(:publisher_profile) { FactoryGirl.create(:publisher_profile) }
  subject!(:publisher_profile_session) { session['user_id'] = publisher_profile.user.id }

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

end
