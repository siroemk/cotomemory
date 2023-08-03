# frozen_string_literal: true

class ChildrenController < ApplicationController
  before_action :set_child, only: %i[edit update destroy]

  def new
    @child = Child.new
  end

  def edit
    @child = Child.find(params[:id])
  end

  def create
    @child = Child.new(child_params)
    @child.family_id = current_user.family_id
    if @child.save
      redirect_to quotes_path, notice: 'こどもの情報を登録しました'
    else
      render :new
    end
  end

  def update
    @child = Child.find(params[:id])
    if @child.update(child_params)
      redirect_to quotes_path, notice: 'こどもの情報を登録しました'
    else
      render :edit
    end
  end

  def destroy
    if @child.destroy
      redirect_to quotes_path, notice: 'こどもの情報を削除しました'
    else
      render :edit
    end
  end

  private

  def child_params
    params.require(:child).permit(:name, :date_of_birth)
  end

  def set_child
    @child = Child.find(params[:id])
  end
end
