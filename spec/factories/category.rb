# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    category_name { 'lt' }

    trait :food do
      category_name { 'food' }
    end

    trait :drink do
      category_name { 'drink' }
    end
  end
end
