# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ad_pricing do
    value_paid_per_visitation 1.5
    campaign nil
    currency nil
  end
end
