require 'spec_helper'

describe ApplicationHelper do

  describe 'roles' do
    # Advertiser
    context "Role #Advertiser" do
      before :each do
        controller.request.path = '/advertisers'
      end

      adv_icon = 'fa-bullhorn'

      it "Role should be Advertiser" do
        helper.role_name.should == 'advertiser' end

      it "Advertiser icon should be #{ adv_icon }" do helper.role_icon.should == adv_icon end

      context "RoleActions for #Advertiser" do
        subject!(:actions) { helper.role_actions }

        context "Act: #recommend -> recommend to another company/advertiser" do
          it "Should route to advertisers/recommend" do
            expected_action = '#recommend'
            was_found_on_action = false
            actions.each do |action|
              if(action[:path] == expected_action)
                was_found_on_action = true
              end
            end
            was_found_on_action.should be_true
          end
        end
        context "Act: #contact -> contact us (feedback)" do
          it "Should route to publishers/invite" do
            expected_action = '#feedback'
            was_found_on_action = false
            actions.each do |action|
              if(action[:path] == expected_action)
                was_found_on_action = true
              end
            end
            was_found_on_action.should be_true
          end
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
      before :each do
        controller.request.path = '/publishers'
      end

      pub_icon = 'fa-rocket'

      it "Role should be Publisher" do
        helper.role_name.should == 'publisher' end

      it "Publisher icon should be #{ pub_icon }" do helper.role_icon.should == pub_icon end

      context "RoleActions for #Publisher" do
        context "Act: #new_social_session -> new social network session to pub" do
          it "Should route to publishers#new_social_session" do helper.role_actions[0][:path].should == '#new_social_session' end
        end
        context "Act: #invite -> invite a friend" do
          it "Should route to publishers#invite" do helper.role_actions[1][:path].should == '#invite' end
        end
        context "Act: #contact -> contact us (feedback)" do
         it "Should route to publishers#contact" do helper.role_actions[4][:path].should == '#feedback' end
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
      before :each do
        controller.request.path = '/admins'
      end

      it "Role should be Admin" do helper.role_name.should == 'admin' end
      it "Role should have empty role_actions" do helper.role_actions.length.should == 0 end
    end

    context "Global Role" do
      before :each do
        controller.request.path = '/globals'
      end

      it "Role should be Global" do helper.role_name.should == 'global' end
      it "Role should be what passed" do helper.role_icon('fa-globe').should == 'fa-globe' end
      it "Role should have empty role_actions" do helper.role_actions.length.should == 0 end
      it "Role should be error if nothing passed and no role name" do helper.role_icon().should == 'fa-error' end
      it "Without a Role should be the role passed as param" do
        helper.role_icon('publisher').should == 'fa-rocket'
        helper.role_icon('advertiser').should == 'fa-bullhorn'
      end
    end
  end

end
