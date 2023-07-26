# frozen_string_literal: true

class QuotesController < ApplicationController
  def index
    @quotes = Quote.where(user_id: current_user.id).includes(:user, :child).order(created_at: :desc)
  end

  def new
    @quote = Quote.new
  end

  def create
    @quote = current_user.quotes.build(quote_params)
    if @quote.save
      respond_to do |format|
        format.html { redirect_to quotes_path, notice: '名言を登録しました' }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def quote_params
    params.require(:quote).permit(:content, :child_id)
  end
end
