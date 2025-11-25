# frozen_string_literal: true

FactoryBot.define do
  factory :entry do
    title { 'クロワッサン' }
    description { 'おすすめです' }

    user
    category
    event

    trait :entry1 do
      title { 'カレー' }
    end

    trait :entry2 do
      title { 'ラーメン' }
    end
  end
end
