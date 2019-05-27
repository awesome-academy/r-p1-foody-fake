class CommentsController < ApplicationController
  include CommentsHelper
  include RestaurantsHelper

  before_action :logged_in_user, :exist_restaurant
  before_action :find_comment, only: %i(edit update destroy get_comment)

  def create
    @comment = Comment.new(comment_params.merge(user_id: current_user.id, restaurant_id: current_restaurant.id))
    if @comment.save
      redirect_to current_restaurant
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def edit; end

  def get_comment
    render json: @comment
  end

  def update
    if @comment.update_attributes comment_params
      flash[:success] = t("success")
    else
      flash[:success] = t("failure")
    end
    redirect_to current_restaurant
  end

  def destroy
    if @comment.destroy
      flash[:success] = t("success_deleted_comment")
    else
      flash[:danger] = t("failure_deleted_comment")
    end
    redirect_to current_restaurant
  end

  private
    def find_comment
      return if @comment = Comment.find_by(id: params[:id])
      render "layouts/notfound"
    end

    def comment_params
      restaurant_id = current_restaurant.id
      params.require(:comment).permit(:content, :comment_id)
    end
end
