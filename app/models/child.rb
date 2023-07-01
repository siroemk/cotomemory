# frozen_string_literal: true

class Child < ApplicationRecord
  belongs_to :family

  validates :name, presence: true
  validates :date_of_birth, presence: true
end
