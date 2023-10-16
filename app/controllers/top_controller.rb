# frozen_string_literal: true

class TopController < ApplicationController
  skip_before_action :authenticate

  def index
    redirect_to quotes_path if logged_in?
  end

  def terms; end

  def privacy; end

  def welcome
    @invitation_token = params[:invitation_token]
  end
end
