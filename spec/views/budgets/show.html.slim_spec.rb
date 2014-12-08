require 'spec_helper'

describe "budgets/show" do
  before(:each) do
    @budget = assign(:budget, stub_model(Budget,
      :active => false,
      :value => 1,
      :currency => nil,
      :campaign => nil,
      :recurrence_period => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    rendered.should match(/1/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
  end
end
