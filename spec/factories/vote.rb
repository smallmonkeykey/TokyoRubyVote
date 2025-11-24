# frozen_string_literal: true

FactoryBot.define do
  factory :vote do
    comment { nil }

    user
    entry
  end
end
