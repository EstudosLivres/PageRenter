# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :budget do
    activated false
    value false
    close_date "MyString"
    currency nil
    campaign nil
    recurrence_period nil
  end
end
