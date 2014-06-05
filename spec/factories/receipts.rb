# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :receipt do
    token "MyString"
    id_on_operator "MyString"
    tid "MyString"
    url_access "MyString"
    transaction nil
  end
end
