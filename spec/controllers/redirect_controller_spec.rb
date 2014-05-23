require 'spec_helper'
require 'factory_girl_rails'

describe RedirectController do
  describe "Root aplication should respond the role URL" do
    context "#Publisher" do
      subject!(:publisher_profile) { FactoryGirl.create(:publisher_profile) }
      subject!(:publisher_profile_session) { session['user_id'] = publisher_profile.user.id }
      it "should responde #/publishers INDEX" do
        get :index
        expect(response).to redirect_to('/publishers')
      end
    end

    context "#Advertiser" do
      subject!(:advertiser_profile) { FactoryGirl.create(:advertiser_profile) }
      subject!(:advertiser_profile_session) { session['user_id'] = advertiser_profile.user.id }
      it "should responde #/advertisers INDEX" do
        get :index
        expect(response).to redirect_to('/advertisers')
      end
    end

    context "#Publisher" do
      subject!(:publisher_profile) { FactoryGirl.create(:publisher_profile) }
      subject!(:publisher_profile_session) { session['user_id'] = publisher_profile.user.id }
      it "should responde #/publishers INDEX" do
        get :index
        expect(response).to redirect_to('/publishers')
      end
    end

    context "#InvalidRole" do
      subject!(:user) { FactoryGirl.create(:user) }
      it "should responde #/advertisers INDEX" do
        get :index
        expect(response).to redirect_to(ApplicationController.land_url)
      end
    end
  end
end
