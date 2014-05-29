require 'spec_helper'

describe "campaigns/show" do
  before(:each) do
    @campaign = assign(:campaign, stub_model(Campaign,
      :name => "Name",
      :redirect_link => "Redirect Link",
      :slogan => "Slogan",
      :description => "Description",
      :social_phrase => "Social Phrase"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Redirect Link/)
    rendered.should match(/Slogan/)
    rendered.should match(/Description/)
    rendered.should match(/Social Phrase/)
  end
end
