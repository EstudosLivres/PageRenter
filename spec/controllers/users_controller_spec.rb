require 'spec_helper'
require 'factory_girl_rails'

describe UsersController do
  context "POST 'login'" do
    subject!(:publisher_profile) { FactoryGirl.create(:publisher_profile) }
    it "Redirect to it role url" do
      post :login, { 'user' => { :password => '123', :email => '11@1.1' } }
      expect(response).to redirect_to('/publishers')
    end
  end
end
