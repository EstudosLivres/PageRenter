require 'spec_helper'

describe "segments/new" do
  before(:each) do
    assign(:segment, stub_model(Segment,
      :name => "MyString",
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new segment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", segments_path, "post" do
      assert_select "input#segment_name[name=?]", "segment[name]"
      assert_select "input#segment_description[name=?]", "segment[description]"
    end
  end
end
