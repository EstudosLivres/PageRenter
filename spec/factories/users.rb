# This will guess the User class
FactoryGirl.define do
  # Users
  factory :user do
    locale      'pt_BR'
    password    '123'
    created_at  { 2.months.ago }

    trait :publisher_user do
      name        'Ilton Garcia'
      nick        'ilton.garcia'
      email       '11@1.1'
    end

    trait :advertiser_user do
      name        'Page Renter'
      nick        'page.renter'
      email       '22@2.2'
    end
  end

  # Profiles
  factory :profile do
    default_role 1

    factory :publisher_profile do
      role_id 1
      association :user, factory: [:user, :publisher_user], name: 'Ilton Garcia'
    end

    factory :advertiser_profile do
      role_id 2
      association :user, factory: [:user, :publisher_user], name: 'Page Renter'
    end
  end


  # TODO advertisers should be write using Sequences
end