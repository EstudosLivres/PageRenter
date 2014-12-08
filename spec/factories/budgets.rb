# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :budget do
    active false
    value 1
    closed_date "2014-07-29 16:03:34"
    currency nil
    campaign nil
    recurrence_period nil
  end
end
