# frozen_string_literal: true

class TopController < ApplicationController
  skip_before_action :authenticate

  def index; end

  def terms; end

  def privacy; end

  def welcome
    @invitation_token = params[:invitation_token]
  end
end
