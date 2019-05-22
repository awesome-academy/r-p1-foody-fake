class CommentLikesController < ApplicationController
  include RestaurantsHelper

  before_action :find_comment, only: %i(destroy)

  def create
    @comment_like = CommentLike.new comment_like_params

    if @comment_like.save
      redirect_to current_restaurant
    else
      render "layouts/notfound"
    end
  end

  def destroy
    if @comment_like.destroy
      redirect_to current_restaurant
    else
      render "layouts/notfound"
    end
  end
  private

    def comment_like_params
      user_id = session[:user_id] || cookies.signed[:user_id]
      params.permit(:comment_id).merge(user_id: user_id)
    end

    def find_comment
      @comment_like = CommentLike.find_by(user_id: current_user.id,comment_id: params[:comment_id])
    end
end
