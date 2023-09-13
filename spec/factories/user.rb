# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: User do
    provider { 'google_oauth2' }
    sequence(:uid) { |i| "uid#{i}" }
    sequence(:name) { |n| "tester#{n}" }
    family
  end
end
