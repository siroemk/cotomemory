# frozen_string_literal: true

class QuotesController < ApplicationController
  before_action :set_quote, only: %i[show edit update destroy]
  before_action :allow_show_quote_page_only_family, only: %i[show edit update destroy]

  def index
    redirect_to new_child_path if current_user.family.children.empty?

    children_ids = current_user.family.children.pluck(:id)
    @quotes = Quote
              .where(child_id: children_ids)
              .includes(:user, :child)
              .order(created_at: :desc)
              .page(params[:page])
  end

  def show
    @comment = Comment.new
    @comments = Comment
                .where(quote_id: params[:id])
                .includes(:user)
                .order(created_at: :asc)
  end

  def new
    @quote = Quote.new
  end

  def edit; end

  def create
    @quote = current_user.quotes.build(quote_params)
    if @quote.save
      respond_to do |format|
        format.html { redirect_to quotes_path, notice: '名言を登録しました' }
        format.turbo_stream { flash.now[:notice] = '名言を登録しました' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @quote.update(quote_params)
      respond_to do |format|
        format.html { redirect_to quotes_path, notice: '名言を更新しました' }
        format.turbo_stream { flash.now[:notice] = '名言を更新しました' }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @quote.destroy
    respond_to do |format|
      format.html { redirect_to quotes_path, notice: '名言を削除しました' }
      format.turbo_stream { flash.now[:notice] = '名言を削除しました' }
    end
  end

  private

  def quote_params
    params.require(:quote).permit(:content, :child_id)
  end

  def set_quote
    @quote = Quote.find(params[:id])
  end

  def allow_show_quote_page_only_family
    return if @quote.child.family == current_user.family

    redirect_to quotes_path, alert: 'ご指定のページはアクセスできませんでした'
  end
end
