require 'spec_helper'

describe "advertisements/index" do
  before(:each) do
    assign(:ads, [
      stub_model(Advertisement,
        :name => "Name"
      ),
      stub_model(Advertisement,
        :name => "Name"
      )
    ])
  end

  it "renders a list of advertisements" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
