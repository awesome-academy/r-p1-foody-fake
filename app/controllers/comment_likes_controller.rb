class CommentLikesController < ApplicationController
  include RestaurantsHelper

  before_action :find_comment, only: %i(destroy)

  def create
    @comment_like = CommentLike.new(comment_like_params.merge(user_id: current_user.id))

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
      user_id = current_user.id
      params.permit(:comment_id)
    end

    def find_comment
      return if @comment_like = CommentLike.find_by(user_id: current_user.id,comment_id: params[:comment_id])
      render "layouts/notfound"
    end
end
