# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    title { 'TokyuRuby会議' }
    status { :open }

    trait :event1 do
      title { 'TokyuRuby会議15' }
    end

    trait :event2 do
      title { 'TokyuRuby会議16' }
    end
  end
end
