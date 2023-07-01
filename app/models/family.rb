# frozen_string_literal: true

class Family < ApplicationRecord
  has_many :children, dependent: :destroy
  has_many :users, dependent: :destroy

  validates :invitation_token, presence: true
end
