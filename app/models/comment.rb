# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :quote
  belongs_to :user

  validates :content, presence: true
end
