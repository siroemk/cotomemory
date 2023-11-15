# frozen_string_literal: true

class FamiliesController < ApplicationController
  def show
    @family = Family.find(current_user.family_id)
    @users = @family.users.excepted(current_user).order(created_at: :asc)
  end
end
