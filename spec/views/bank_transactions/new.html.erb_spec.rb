require 'spec_helper'

describe "bank_transactions/new" do
  before(:each) do
    assign(:bank_transaction, stub_model(BankTransaction,
      :value => "9.99",
      :currency => "MyString",
      :banking => false,
      :payment_method => nil,
      :payer => nil,
      :receiver => nil
    ).as_new_record)
  end

  it "renders new bank_transaction form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", transactions_path, "post" do
      assert_select "input#transaction_value[name=?]", "bank_transaction[value]"
      assert_select "input#transaction_currency[name=?]", "bank_transaction[currency]"
      assert_select "input#transaction_banking[name=?]", "bank_transaction[banking]"
      assert_select "input#transaction_payment_method[name=?]", "bank_transaction[payment_method]"
      assert_select "input#transaction_payer[name=?]", "bank_transaction[payer]"
      assert_select "input#transaction_receiver[name=?]", "bank_transaction[receiver]"
    end
  end
end
