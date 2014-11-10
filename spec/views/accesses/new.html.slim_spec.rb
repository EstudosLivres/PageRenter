require 'spec_helper'

describe "accesses/new" do
  before(:each) do
    assign(:access, stub_model(Access,
      :converted => false,
      :remote_id => "MyString",
      :social_network_id => "",
      :profile => nil,
      :ad => nil
    ).as_new_record)
  end

  it "renders new access form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", accesses_path, "post" do
      assert_select "input#access_converted[name=?]", "access[converted]"
      assert_select "input#access_remote_id[name=?]", "access[remote_id]"
      assert_select "input#access_social_network_id[name=?]", "access[social_network_id]"
      assert_select "input#access_profile[name=?]", "access[profile]"
      assert_select "input#access_ad[name=?]", "access[ad]"
    end
  end
end
