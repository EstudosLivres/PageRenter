# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    value "9.99"
    currency "MyString"
    banking false
    payment_method nil
    payer nil
    receiver nil
  end
end
