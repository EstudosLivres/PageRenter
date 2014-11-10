require 'spec_helper'

describe "accesses/index" do
  before(:each) do
    assign(:accesses, [
      stub_model(Access,
        :converted => false,
        :remote_id => "Remote",
        :social_network_id => "",
        :profile => nil,
        :ad => nil
      ),
      stub_model(Access,
        :converted => false,
        :remote_id => "Remote",
        :social_network_id => "",
        :profile => nil,
        :ad => nil
      )
    ])
  end

  it "renders a list of accesses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Remote".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
