# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_quote, only: %i[create destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.quote = @quote
    if @comment.save
      respond_to do |format|
        format.html { redirect_to quote_comments_path(@quote), notice: 'コメントしました' }
        format.turbo_stream { flash.now[:notice] = 'コメントしました' }
      end
    else
      render 'quotes/show', status: :unprocessable_content
    end
  end

  def destroy
    @comment = @quote.comments.find(params.expect(:id))

    return render 'quotes/show', status: :unprocessable_content unless current_user == @comment.user

    @comment.destroy
    respond_to do |format|
      format.html { redirect_to quote_comments_path(@quote), notice: 'コメントを削除しました' }
      format.turbo_stream { flash.now[:notice] = 'コメントを削除しました' }
    end
  end

  private

  def comment_params
    params.expect(comment: [:content])
  end

  def set_quote
    @quote = Quote.find(params.expect(:quote_id))
  end
end
