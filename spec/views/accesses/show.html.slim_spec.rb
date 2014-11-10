require 'spec_helper'

describe "accesses/show" do
  before(:each) do
    @access = assign(:access, stub_model(Access,
      :converted => false,
      :remote_id => "Remote",
      :social_network_id => "",
      :profile => nil,
      :ad => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    rendered.should match(/Remote/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
  end
end
