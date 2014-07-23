require 'spec_helper'

describe "advertisements/show" do
  before(:each) do
    @advertisement = assign(:advertisement, stub_model(Advertisement,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
