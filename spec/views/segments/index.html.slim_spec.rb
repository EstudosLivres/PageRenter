require 'spec_helper'

describe "segments/index" do
  before(:each) do
    assign(:segments, [
      stub_model(Segment,
        :name => "Name",
        :description => "Description"
      ),
      stub_model(Segment,
        :name => "Name",
        :description => "Description"
      )
    ])
  end

  it "renders a list of segments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
