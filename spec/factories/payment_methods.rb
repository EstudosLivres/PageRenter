# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment_method, :class => 'PaymentMethods' do
    name "MyString"
    method_type "MyString"
    description "MyString"
  end
end
