# frozen_string_literal: true

class UsersController < ApplicationController
  def edit; end

  def destroy
    current_user.destroy!
    reset_session
    redirect_to root_path, notice: 'アカウントを削除しました'
  end
end
