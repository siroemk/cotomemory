# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :family
  has_many :quotes, dependent: :nullify

  validates :name, presence: true
  validates :uid, presence: true
  validates :provider, presence: true
end
