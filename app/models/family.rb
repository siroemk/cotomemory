# frozen_string_literal: true

class Family < ApplicationRecord
  validates :invitation_token, presence: true
end
