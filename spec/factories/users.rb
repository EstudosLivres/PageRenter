# This will guess the User class
FactoryGirl.define do
  factory :user, aliases: [:publisher_user] do
    name        'Ilton Garcia'
    nick        'ilton.garcia'
    email       '11@1.1'
    locale      'pt_BR'
    password    '123'
    created_at  { 2.months.ago }
  end

  factory :profile, aliases: [:publisher_profile] do
    default_role 1
    user_id 1
    role_id 1
    user
  end

=begin
  factory :user, aliases: [:publishers] do
    sequence(:name) { |i| 'Ash#{i}' }
    sequence(:nick) { |i| 'Ash.#{i}' }
    sequence(:email) { |i| 'Ash@#{i}.#{i}' }
    locale 'pt_BR'
    pass_salt '$2a$10$9A3qM2mjS1/akUoDjTWdy.'
    password '$2a$10$9A3qM2mjS1/akUoDjTWdy.zjfQP/K8PbsH1NZhMTkmLlI/QqHk25i'
    created_at   { 2.months.ago }
  end


    # Profiles
    factory :user_with_profile do
      # profiles_count is declared as an ignored attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      ignore do
        profiles_count 1
      end

      after(:create) do |user, evaluator|
        create_list(:profile, evaluator.profiles_count, user: user)
      end
    end
=end
end