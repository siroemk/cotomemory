# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true
  validates :uid, presence: true
  validates :provider, presence: true
end
