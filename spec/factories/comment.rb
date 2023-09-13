# frozen_string_literal: true

FactoryBot.define do
  factory :comment, class: 'Comment' do
    content { 'こんなことを言えるようになったんだね' }
    user
    quote
  end
end
