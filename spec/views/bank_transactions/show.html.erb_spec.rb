require 'spec_helper'

describe "bank_transactions/show" do
  before(:each) do
    @bank_transaction = assign(:bank_transaction, stub_model(BankTransaction,
      :value => "9.99",
      :currency => "Currency",
      :banking => false,
      :payment_method => nil,
      :payer => nil,
      :receiver => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/9.99/)
    rendered.should match(/Currency/)
    rendered.should match(/false/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
  end
end
