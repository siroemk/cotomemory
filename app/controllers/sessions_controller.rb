# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate, only: :create

  def create
    user = User.from_omniauth(request.env['omniauth.auth'])
    if user.family_id.nil?
      invitation_token = request.env['omniauth.params']['invitation_token']
      if invitation_token.present?
        family = Family.find_by!(invitation_token:)
        user.family = family
      else
        user.build_family(invitation_token: SecureRandom.urlsafe_base64)
      end
    end

    if user.save
      session[:user_id] = user.id
      if Child.find_by(family_id: user.family_id).nil?
        redirect_to new_child_path, notice: 'ログインしました'
      else
        redirect_to quotes_path, notice: 'ログインしました'
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました'
  end
end
