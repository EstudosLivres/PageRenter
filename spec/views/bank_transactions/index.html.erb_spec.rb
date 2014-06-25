require 'spec_helper'

describe "bank_transactions/index" do
  before(:each) do
    assign(:bank_transactions, [
      stub_model(BankTransaction,
        :value => "9.99",
        :currency => "Currency",
        :banking => false,
        :payment_method => nil,
        :payer => nil,
        :receiver => nil
      ),
      stub_model(BankTransaction,
        :value => "9.99",
        :currency => "Currency",
        :banking => false,
        :payment_method => nil,
        :payer => nil,
        :receiver => nil
      )
    ])
  end

  it "renders a list of bank_transactions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Currency".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
