# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :social_session_segment do
    segment nil
    social_session nil
    id_on_social "MyString"
  end
end
