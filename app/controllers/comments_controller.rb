class CommentsController < ApplicationController
  include CommentsHelper
  include RestaurantsHelper

  before_action :logged_in_user, :exist_restaurant

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to current_restaurant
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    if @comment.destroy
      flash[:success] = t("success_deleted_comment")
    else
      flash[:danger] = t("failure_deleted_comment")
    end
    redirect_to current_restaurant
  end

  private
    def comment_params
      user_id = session[:user_id] || cookies.signed[:user_id]
      restaurant_id = session[:restaurant_id] || cookies.signed[:restaurant_id]
      params.require(:comment).permit(:content, :comment_id).merge(user_id: user_id, restaurant_id: restaurant_id)
    end
end
