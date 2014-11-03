require 'spec_helper'

describe "banned_ad_histories/edit" do
  before(:each) do
    @banned_ad_history = assign(:banned_ad_history, stub_model(BannedAdHistory,
      :reason => "MyString",
      :description => "MyString",
      :user => nil,
      :ad => nil
    ))
  end

  it "renders the edit banned_ad_history form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", banned_ad_history_path(@banned_ad_history), "post" do
      assert_select "input#banned_ad_history_reason[name=?]", "banned_ad_history[reason]"
      assert_select "input#banned_ad_history_description[name=?]", "banned_ad_history[description]"
      assert_select "input#banned_ad_history_user[name=?]", "banned_ad_history[user]"
      assert_select "input#banned_ad_history_ad[name=?]", "banned_ad_history[ad]"
    end
  end
end
