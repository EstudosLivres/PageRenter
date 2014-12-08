require 'spec_helper'

describe "budgets/edit" do
  before(:each) do
    @budget = assign(:budget, stub_model(Budget,
      :active => false,
      :value => false,
      :close_date => "MyString",
      :currency => nil,
      :campaign => nil,
      :recurrence_period => nil
    ))
  end

  it "renders the edit budget form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", budget_path(@budget), "post" do
      assert_select "input#budget_activated[name=?]", "budget[activated]"
      assert_select "input#budget_value[name=?]", "budget[value]"
      assert_select "input#budget_close_date[name=?]", "budget[close_date]"
      assert_select "input#budget_currency[name=?]", "budget[currency]"
      assert_select "input#budget_campaign[name=?]", "budget[campaign]"
      assert_select "input#budget_recurrence_period[name=?]", "budget[recurrence_period]"
    end
  end
end
