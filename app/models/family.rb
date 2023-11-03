# frozen_string_literal: true

class Family < ApplicationRecord
  has_many :children, dependent: :destroy
  has_many :users, dependent: :destroy

  validates :invitation_token, presence: true

  def destoy_when_all_families_left!
    return if User.exists?(family_id: id)

    Family.find(id).destroy!
  end
end
