# frozen_string_literal: true

FactoryBot.define do
  factory :child, class: 'Child' do
    name { 'みいひ' }
    date_of_birth { '2020/01/01' }
    family
  end
end
