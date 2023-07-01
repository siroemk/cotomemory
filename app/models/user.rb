# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :family
  has_many :quotes, dependent: :nullify
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :uid, presence: true
  validates :provider, presence: true
end
