# frozen_string_literal: true

class QuotesController < ApplicationController
  def index; end

  def new
    @quote = Quote.new
  end

  def create
    @quote = Quote.new(quote_params)
    @quote.user_id = current_user.id
    if @quote.save
      redirect_to quotes_path
    else
      render :new
    end
  end

  private

  def quote_params
    params.require(:quote).permit(:content, :child_id)
  end
end
