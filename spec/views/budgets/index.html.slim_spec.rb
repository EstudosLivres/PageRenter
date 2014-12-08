require 'spec_helper'

describe "budgets/index" do
  before(:each) do
    assign(:budgets, [
      stub_model(Budget,
        :active => false,
        :value => 1,
        :currency => nil,
        :campaign => nil,
        :recurrence_period => nil
      ),
      stub_model(Budget,
        :active => false,
        :value => 1,
        :currency => nil,
        :campaign => nil,
        :recurrence_period => nil
      )
    ])
  end

  it "renders a list of budgets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
