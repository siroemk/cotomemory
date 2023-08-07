# frozen_string_literal: true

class FamiliesController < ApplicationController
  def show
    @family = Family.find(current_user.family_id)
  end
end
