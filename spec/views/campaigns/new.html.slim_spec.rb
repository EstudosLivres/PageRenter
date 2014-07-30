require 'spec_helper'

describe "campaigns/new" do
  before(:each) do
    assign(:campaign, stub_model(Campaign,
      :name => "MyString",
      :redirect_link => "MyString",
      :slogan => "MyString",
      :description => "MyString",
      :social_phrase => "MyString"
    ).as_new_record)
  end

=begin
  it "renders new campaign form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", campaigns_path, "post" do
      assert_select "input#campaign_name[name=?]", "campaign[name]"
      assert_select "input#campaign_redirect_link[name=?]", "campaign[redirect_link]"
      assert_select "input#campaign_slogan[name=?]", "campaign[slogan]"
      # assert_select "input#campaign_description[name=?]", "campaign[description]"
      assert_select "input#campaign_social_phrase[name=?]", "campaign[social_phrase]"
    end
  end
=end
end
