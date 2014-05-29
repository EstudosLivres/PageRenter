require 'spec_helper'

describe "campaigns/index" do
  before(:each) do
    assign(:campaigns, [
      stub_model(Campaign,
        :name => "Name",
        :redirect_link => "Redirect Link",
        :slogan => "Slogan",
        :description => "Description",
        :social_phrase => "Social Phrase"
      ),
      stub_model(Campaign,
        :name => "Name",
        :redirect_link => "Redirect Link",
        :slogan => "Slogan",
        :description => "Description",
        :social_phrase => "Social Phrase"
      )
    ])
  end

  it "renders a list of campaigns" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Redirect Link".to_s, :count => 2
    assert_select "tr>td", :text => "Slogan".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Social Phrase".to_s, :count => 2
  end
end
