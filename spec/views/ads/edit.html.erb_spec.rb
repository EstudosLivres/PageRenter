require 'spec_helper'

describe "advertisements/edit" do
  before(:each) do
    @advertisement = assign(:advertisement, stub_model(Advertisement,
      :name => "MyString"
    ))
  end

  it "renders the edit advertisement form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", advertisement_path(@advertisement), "post" do
      assert_select "input#advertisement_name[name=?]", "advertisement[name]"
    end
  end
end
