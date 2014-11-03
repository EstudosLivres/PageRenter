require 'spec_helper'

describe "banned_ad_histories/show" do
  before(:each) do
    @banned_ad_history = assign(:banned_ad_history, stub_model(BannedAdHistory,
      :reason => "Reason",
      :description => "Description",
      :user => nil,
      :ad => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Reason/)
    rendered.should match(/Description/)
    rendered.should match(//)
    rendered.should match(//)
  end
end
