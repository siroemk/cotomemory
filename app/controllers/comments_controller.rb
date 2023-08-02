# frozen_string_literal: true

class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.quote_id = params[:quote_id]
    if @comment.save
      respond_to do |format|
        format.html { redirect_to quote_comments_path(:quote_id), notice: 'コメントしました' }
        format.turbo_stream
      end
    else
      @quote = Quote.find(params[:id])
      render 'quotes/show', status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
