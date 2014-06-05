require 'spec_helper'

describe "transactions/new" do
  before(:each) do
    assign(:transaction, stub_model(Transaction,
      :value => "9.99",
      :currency => "MyString",
      :banking => false,
      :payment_method => nil,
      :payer => nil,
      :receiver => nil
    ).as_new_record)
  end

  it "renders new transaction form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", transactions_path, "post" do
      assert_select "input#transaction_value[name=?]", "transaction[value]"
      assert_select "input#transaction_currency[name=?]", "transaction[currency]"
      assert_select "input#transaction_banking[name=?]", "transaction[banking]"
      assert_select "input#transaction_payment_method[name=?]", "transaction[payment_method]"
      assert_select "input#transaction_payer[name=?]", "transaction[payer]"
      assert_select "input#transaction_receiver[name=?]", "transaction[receiver]"
    end
  end
end
