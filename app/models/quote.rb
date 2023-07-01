# frozen_string_literal: true

class Quote < ApplicationRecord
  belongs_to :child
  belongs_to :user

  validates :content, presence: true
end
