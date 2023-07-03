# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :family
  has_many :quotes, dependent: :nullify
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :uid, presence: true
  validates :provider, presence: true

  def self.from_omniauth(auth_hash)
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    name = auth_hash[:info][:name]
    User.where(provider:, uid:, name:).first_or_initialize
  end
end
