# frozen_string_literal: true

class ChildrenController < ApplicationController
  before_action :set_child, only: %i[edit update destroy]
  before_action :allow_show_children_page_only_family, only: %i[edit update destroy]

  def index
    @children = current_user.family.children.order(created_at: :asc)
  end

  def new
    @child = Child.new
  end

  def edit; end

  def create
    @child = current_user.family.children.new(child_params)
    if @child.save
      redirect_to quotes_path, notice: 'こどもの情報を登録しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @child.update(child_params)
      redirect_to children_path, notice: 'こどもの情報を編集しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @child.destroy

    redirect_to children_path, notice: 'こどもの情報を削除しました', status: :see_other
  end

  private

  def child_params
    params.require(:child).permit(:name, :date_of_birth)
  end

  def set_child
    @child = Child.find(params[:id])
  end

  def allow_show_children_page_only_family
    redirect_to children_path, notice: '他の家族の情報にアクセスすることはできません' unless @child.family_id == current_user.family_id
  end
end
