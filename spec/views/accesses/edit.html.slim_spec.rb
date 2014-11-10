require 'spec_helper'

describe "accesses/edit" do
  before(:each) do
    @access = assign(:access, stub_model(Access,
      :converted => false,
      :remote_id => "MyString",
      :social_network_id => "",
      :profile => nil,
      :ad => nil
    ))
  end

  it "renders the edit access form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", access_path(@access), "post" do
      assert_select "input#access_converted[name=?]", "access[converted]"
      assert_select "input#access_remote_id[name=?]", "access[remote_id]"
      assert_select "input#access_social_network_id[name=?]", "access[social_network_id]"
      assert_select "input#access_profile[name=?]", "access[profile]"
      assert_select "input#access_ad[name=?]", "access[ad]"
    end
  end
end
