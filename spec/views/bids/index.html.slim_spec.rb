require 'spec_helper'

describe "bids/index" do
  before(:each) do
    assign(:bids, [
      stub_model(Bid,
        :visitation => 1.5,
        :impression => 1.5,
        :foreign_interactions => "9.99",
        :local_interactions => "9.99",
        :ad => nil,
        :currency => nil
      ),
      stub_model(Bid,
        :visitation => 1.5,
        :impression => 1.5,
        :foreign_interactions => "9.99",
        :local_interactions => "9.99",
        :ad => nil,
        :currency => nil
      )
    ])
  end

  it "renders a list of bids" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
