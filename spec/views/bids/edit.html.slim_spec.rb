require 'spec_helper'

describe "bids/edit" do
  before(:each) do
    @bid = assign(:bid, stub_model(Bid,
      :visitation => 1.5,
      :impression => 1.5,
      :foreign_interactions => "9.99",
      :local_interactions => "9.99",
      :ad => nil,
      :currency => nil
    ))
  end

  it "renders the edit bid form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", bid_path(@bid), "post" do
      assert_select "input#bid_visitation[name=?]", "bid[visitation]"
      assert_select "input#bid_impression[name=?]", "bid[impression]"
      assert_select "input#bid_foreign_interactions[name=?]", "bid[foreign_interactions]"
      assert_select "input#bid_local_interactions[name=?]", "bid[local_interactions]"
      assert_select "input#bid_ad[name=?]", "bid[ad]"
      assert_select "input#bid_currency[name=?]", "bid[currency]"
    end
  end
end
