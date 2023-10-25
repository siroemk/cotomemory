# frozen_string_literal: true

class TopController < ApplicationController
  skip_before_action :login_required

  def index
    redirect_to quotes_path if logged_in?
  end

  def terms; end

  def privacy; end

  def welcome
    family = Family.find_by!(invitation_token: params[:invitation_token])
    @invitation_token = family.invitation_token
  end
end
