require 'spec_helper'

describe "banned_ad_histories/index" do
  before(:each) do
    assign(:banned_ad_histories, [
      stub_model(BannedAdHistory,
        :reason => "Reason",
        :description => "Description",
        :user => nil,
        :ad => nil
      ),
      stub_model(BannedAdHistory,
        :reason => "Reason",
        :description => "Description",
        :user => nil,
        :ad => nil
      )
    ])
  end

  it "renders a list of banned_ad_histories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Reason".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
