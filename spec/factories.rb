# This will guess the User class
FactoryGirl.define do
  factory :user do
    name 'Ilton Garcia'
    nick 'ilton.garcia'
    email '33@3.3'
    locale 'pt_BR'
    pass_salt '$2a$10$9A3qM2mjS1/akUoDjTWdy.'
    password '$2a$10$9A3qM2mjS1/akUoDjTWdy.zjfQP/K8PbsH1NZhMTkmLlI/QqHk25i'
  end
end