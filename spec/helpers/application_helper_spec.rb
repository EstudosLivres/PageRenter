require 'spec_helper'

describe ApplicationHelper do

  describe 'roles' do
    # Advertiser
    context "Role #Advertiser" do
      subject! { controller.params = { 'controller' => 'advertisers' } }
      adv_icon = 'fa-bullhorn'

      it "Role should be Advertiser" do helper.role_name.should == 'advertiser' end

      it "Advertiser icon should be #{ adv_icon }" do helper.role_icon.should == adv_icon end

      context "RoleActions for #Advertiser" do
        context "Act: #recommend -> recommend to another company/advertiser" do
          it "Should route to advertisers/recommend" do helper.role_actions[0][:path].should == '#recommend' end
        end
        context "Act: #contact -> contact us (feedback)" do
          it "Should route to publishers/invite" do helper.role_actions[1][:path].should == '#feedback' end
        end
      end

      context "Default button for #Advertiser" do
        it "Should be success btn" do
          helper.current_button.should == 'btn-primary'
        end
      end
    end

    # Publisher
    context "Role #Publisher" do
      subject! { controller.params = { 'controller' => 'publishers' } }
      pub_icon = 'fa-rocket'

      it "Role should be Publisher" do helper.role_name.should == 'publisher' end

      it "Publisher icon should be #{ pub_icon }" do helper.role_icon.should == pub_icon end

      context "RoleActions for #Publisher" do
        context "Act: #invite -> invite a friend" do
          it "Should route to publishers/invite" do helper.role_actions[0][:path].should == '#invite' end
        end
        context "Act: #contact -> contact us (feedback)" do
         it "Should route to publishers/invite" do helper.role_actions[1][:path].should == '#feedback' end
        end
      end

      context "Default button for #Publisher" do
        it "Should be success btn" do
          helper.current_button.should == 'btn-success'
        end
      end
    end

    # Admin (not implemented yet)
    context "Role #Admin" do
      subject! { controller.params = { 'controller' => 'admins' } }

      it "Role should be Admin" do helper.role_name.should == 'admin' end
      it "Role should have empty role_actions" do helper.role_actions.length.should == 1 end
    end
  end

end
