# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :family
  has_many :quotes, dependent: :nullify
  has_many :comments, dependent: :destroy
  has_one_attached :avatar

  validates :name, presence: true
  validates :uid, presence: true
  validates :provider, presence: true
  validate :validate_avatar

  def self.from_omniauth(auth_hash)
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]

    existing_user = User.find_by(uid:)
    name = existing_user ? existing_user.name : auth_hash[:info][:name]

    User.where(provider:, uid:, name:).first_or_initialize
  end

  private

  def validate_avatar
    return unless avatar.attached?

    if avatar.blob.byte_size > 1.megabytes
      errors.add(:avatar, 'のファイルサイズは1MB以下にしてください')
    elsif !image?
      errors.add(:avatar, 'はjpeg,jpg,pngのいずれかにしてください')
    end
  end

  def image?
    avatar.content_type.in?(%("image/jpeg image/jpg image/png"))
  end
end
