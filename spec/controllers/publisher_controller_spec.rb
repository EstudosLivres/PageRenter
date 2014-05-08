require 'spec_helper'

describe PublisherController do

  describe "GET 'index' with idiom" do
    it "returns http success with 'en' idiom" do
      expect(:get => '/en/publisher').to route_to(:controller => 'publisher',:idiom => 'en',:action => 'index')
    end
    it "returns http success with 'pt' idiom" do
      expect(:get => '/pt/publisher').to route_to(:controller => 'publisher',:idiom => 'pt',:action => 'index')
    end
  end

end
