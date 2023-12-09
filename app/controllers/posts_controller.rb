class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def new
    @user = User.find_by(id: params[:user_id]) || current_user

    @post = @user.posts.build
  end

  def show; end

  def create
    user = User.find_by(id: params[:user_id]) || current_user

    @post = user.posts.build(post_params)

    if @post.save
      redirect_to post_path(@post), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to user_posts_path(current_user), notice: 'Post was successfully destroyed.'
  end

  def index
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      @posts = @user ? @user.posts : Post.none
    else
      @posts = Post.all
    end
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
    return unless @post.nil?

    flash[:alert] = 'Post not found.'
    redirect_to root_path
  end

  def post_params
    params.require(:post).permit(:title, :text, :comments_counter, :likes_counter)
  end
end
