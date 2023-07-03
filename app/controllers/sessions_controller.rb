# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(request.env['omniauth.auth'])
    user.build_family(invitation_token: SecureRandom.urlsafe_base64)

    if user.save
      session[:user_id] = user.id
      redirect_to quotes_path, notice: 'ログインしました！'
    else
      redirect_to root_path
    end
  end
end
