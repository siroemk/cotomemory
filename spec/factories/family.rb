# frozen_string_literal: true

FactoryBot.define do
  factory :family, class: Family do
    sequence(:invitation_token) { |n| "abcde12345#{n}" }
  end
end
