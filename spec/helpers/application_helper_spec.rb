require 'spec_helper'

describe ApplicationHelper do

  describe 'roles' do
    # Advertiser
    context "Role #Advertiser" do
      subject! { controller.params = { 'controller' => 'advertisers' } }
      adv_icon = 'fa-bullhorn'

      it "Role should be Advertiser" do
        helper.role_name.should == 'advertiser'
      end

      it "Advertiser icon should be #{ adv_icon }" do
        helper.role_icon.should == adv_icon
      end
    end

    # Publisher
    context "Role #Publisher" do
      subject! { controller.params = { 'controller' => 'publishers' } }
      pub_icon = 'fa-rocket'

      it "Role should be Publisher" do
        helper.role_name.should == 'publisher'
      end

      it "Publisher icon should be #{ pub_icon }" do
        helper.role_icon.should == pub_icon
      end
    end
  end

end
