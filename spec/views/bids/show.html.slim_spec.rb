require 'spec_helper'

describe "bids/show" do
  before(:each) do
    @bid = assign(:bid, stub_model(Bid,
      :visitation => 1.5,
      :impression => 1.5,
      :foreign_interactions => "9.99",
      :local_interactions => "9.99",
      :campaign => nil,
      :currency => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
    rendered.should match(//)
    rendered.should match(//)
  end
end
