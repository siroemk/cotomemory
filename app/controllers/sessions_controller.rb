# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate, only: :create

  def create
    user = User.from_omniauth(request.env['omniauth.auth'])
    user.build_family(invitation_token: SecureRandom.urlsafe_base64) if user.family_id.nil?

    if user.save
      session[:user_id] = user.id
      child = Child.find_by(family_id: user.family_id)
      if child.nil?
        redirect_to new_child_path
      else
        redirect_to quotes_path, notice: 'ログインしました！'
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました！'
  end
end
