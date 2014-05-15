require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe ApplicationHelper do

  describe 'roles' do
    context "Role Advertiser" do
      it "Role should be Advertiser" do
        controller.params = { 'controller' => 'advertisers' }
        helper.role_name.should == 'advertiser'
      end
    end
    context "Role Publisher" do
      it "Role should be Advertiser" do
        controller.params = { 'controller' => 'publishers' }
        helper.role_name.should == 'publisher'
      end
    end
  end

end
