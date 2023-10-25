# frozen_string_literal: true

class FamiliesController < ApplicationController
  def show
    @family = Family.find(current_user.family_id)
    @users = User.where(family_id: current_user.family_id).where.not(id: current_user.id).order(created_at: :asc)
  end
end
