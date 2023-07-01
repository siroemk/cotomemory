# frozen_string_literal: true

class Child < ApplicationRecord
  belongs_to :family
  has_many :quotes, dependent: :destroy

  validates :name, presence: true
  validates :date_of_birth, presence: true
end
