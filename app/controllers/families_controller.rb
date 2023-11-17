# frozen_string_literal: true

class FamiliesController < ApplicationController
  def show
    @family = current_user.family
    @users = @family.users.excepted(current_user).order(created_at: :asc)
  end
end
