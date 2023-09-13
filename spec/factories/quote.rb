# frozen_string_literal: true

FactoryBot.define do
  factory :quote, class: 'Quote' do
    content { 'ママもお勉強がんばってね！' }
    user
    child
  end
end
