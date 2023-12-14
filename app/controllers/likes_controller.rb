class LikesController < ApplicationController
  before_action :set_post

  def create
    if @post.increment!(:likes_counter)
      redirect_to @post, notice: 'You liked the post!'
    else
      redirect_to root_path, alert: 'Unable to like the post.'
    end
  end

  private

  def set_post
    @post = Post.find_by(id: params[:post_id])
    return if @post.present?

    flash[:alert] = 'Post not found.'
    redirect_to root_path
  end
end
