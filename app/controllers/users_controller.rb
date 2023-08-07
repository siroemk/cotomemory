# frozen_string_literal: true

class UsersController < ApplicationController
  def edit; end

  def update
    if current_user.update(user_params)
      redirect_to quotes_path, notice: 'ユーザー情報を更新しました'
    else
      render :edit
    end
  end

  def destroy
    current_user.destroy!
    reset_session
    redirect_to root_path, notice: 'アカウントを削除しました'
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
