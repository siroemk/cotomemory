# frozen_string_literal: true

class Quote < ApplicationRecord
  belongs_to :child
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :content, presence: true, length: { maximum: 500 }
end
