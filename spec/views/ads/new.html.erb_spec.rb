require 'spec_helper'

describe "advertisements/new" do
  before(:each) do
    assign(:advertisement, stub_model(Advertisement,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new advertisement form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", advertisements_path, "post" do
      assert_select "input#advertisement_name[name=?]", "advertisement[name]"
    end
  end
end
