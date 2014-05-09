require 'spec_helper'

describe AdvertiserController do

  describe "GET 'index' with idiom" do
    it "returns http success with 'en' idiom" do
      expect(:get => '/en/advertiser').to route_to(:controller => 'advertiser',:idiom => 'en',:action => 'index')
    end
    it "returns http success with 'pt' idiom" do
      expect(:get => '/pt/advertiser').to route_to(:controller => 'advertiser',:idiom => 'pt',:action => 'index')
    end
  end

end
