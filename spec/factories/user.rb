# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    provider { 'github' }
    sequence(:uid) { |n| "user_uid_#{n}" }
    name { 'smallmonkey' }
    admin { false }
    session_digest { nil }

    trait :admin do
      admin { true }
      name { 'admin_user' }
      uid  { 'admin_uid' }
    end
  end
end
