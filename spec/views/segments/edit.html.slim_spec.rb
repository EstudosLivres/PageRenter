require 'spec_helper'

describe "segments/edit" do
  before(:each) do
    @segment = assign(:segment, stub_model(Segment,
      :name => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit segment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", segment_path(@segment), "post" do
      assert_select "input#segment_name[name=?]", "segment[name]"
      assert_select "input#segment_description[name=?]", "segment[description]"
    end
  end
end
